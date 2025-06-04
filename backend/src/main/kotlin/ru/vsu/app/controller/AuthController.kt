package ru.vsu.app.controller

import ru.vsu.app.dto.responses.auth.login.LoginUser200Response
import ru.vsu.app.dto.responses.auth.login.LoginUser400Response
import ru.vsu.app.dto.responses.auth.login.LoginUser401Response
import ru.vsu.app.dto.requests.LoginUserRequest

import ru.vsu.app.dto.responses.auth.register.RegisterUser200Response
import ru.vsu.app.dto.responses.auth.register.RegisterUser400Response
import ru.vsu.app.dto.responses.auth.register.RegisterUser409Response
import ru.vsu.app.dto.requests.RegisterUserRequest

import ru.vsu.app.dto.responses.common.InternalServerError

import ru.vsu.app.dto.responses.auth.requestpassword.RequestPasswordReset200Response
import ru.vsu.app.dto.responses.auth.requestpassword.RequestPasswordReset400Response
import ru.vsu.app.dto.responses.auth.requestpassword.RequestPasswordReset404Response
import ru.vsu.app.dto.requests.RequestPasswordResetRequest

import ru.vsu.app.dto.responses.auth.requestpassword.ResetPassword200Response
import ru.vsu.app.dto.responses.auth.requestpassword.ResetPassword400Response
import ru.vsu.app.dto.requests.ResetPasswordRequest

import ru.vsu.app.dto.responses.auth.verifyemail.ResendVerificationCode200Response
import ru.vsu.app.dto.requests.ResendVerificationCodeRequest

import ru.vsu.app.dto.responses.auth.verifyemail.VerifyEmail400Response
import ru.vsu.app.dto.responses.auth.verifyemail.VerifyEmail410Response
import ru.vsu.app.dto.requests.VerifyEmailRequest

import ru.vsu.app.dto.responses.auth.AuthCheckGet401Response

import ru.vsu.app.dto.responses.auth.refreshtoken.AuthRefreshToken200Response
import ru.vsu.app.dto.responses.auth.refreshtoken.AuthRefreshToken401Response
import ru.vsu.app.dto.requests.AuthRefreshRequest

import ru.vsu.app.dto.UserDto

import ru.vsu.app.service.AuthService
import ru.vsu.app.service.JwtService

import ru.vsu.app.metrics.AuthMetrics

import io.swagger.v3.oas.annotations.*
import io.swagger.v3.oas.annotations.enums.*
import io.swagger.v3.oas.annotations.media.*
import io.swagger.v3.oas.annotations.responses.*
import io.swagger.v3.oas.annotations.security.*
import io.swagger.v3.oas.annotations.tags.Tag
import org.springframework.http.HttpStatus
import org.springframework.http.MediaType
import org.springframework.http.ResponseEntity

import org.springframework.web.bind.annotation.*
import org.springframework.validation.annotation.Validated
import org.springframework.web.context.request.NativeWebRequest
import org.springframework.beans.factory.annotation.Autowired

import jakarta.validation.Valid
import jakarta.validation.constraints.DecimalMax
import jakarta.validation.constraints.DecimalMin
import jakarta.validation.constraints.Email
import jakarta.validation.constraints.Max
import jakarta.validation.constraints.Min
import jakarta.validation.constraints.NotNull
import jakarta.validation.constraints.Pattern
import jakarta.validation.constraints.Size

import kotlin.collections.List
import kotlin.collections.Map

@RestController
@Validated
@RequestMapping("\${api.base-path:/api}")
@SecurityRequirement(name = "Bearer Authentication")
@Tag(name = "Authentication", description = "Регистрация, вход и управление аккаунтом")
class AuthController(
    private val authService: AuthService,
    private val jwtService: JwtService,
    private val authMetrics: AuthMetrics
) {

    @Operation(
        summary = "Проверка статуса аутентификации",
        operationId = "authCheckGet",
        description = """Проверяет, авторизован ли пользователь по сессионной cookie.
Возвращает данные пользователя, если сессия активна.
""",
        responses = [
            ApiResponse(responseCode = "200", description = "Пользователь авторизован", content = [Content(schema = Schema(implementation = UserDto::class))]),
            ApiResponse(responseCode = "401", description = "Пользователь не авторизован", content = [Content(schema = Schema(implementation = AuthCheckGet401Response::class))]),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.GET],
        value = ["/auth/check"],
        produces = ["application/json"]
    )
        fun authCheckGet(): ResponseEntity<Any> {
            authMetrics.authCheckAttempt()
            val startTime = System.currentTimeMillis()

            val user = authService.getCurrentUser()
            val response: ResponseEntity<Any> = if (user != null) {
                authMetrics.authCheckAuthorized()
                ResponseEntity.ok(user)
            } else {
                authMetrics.authCheckUnauthorized()
                ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body(AuthCheckGet401Response(false, "Пользователь не авторизован"))
            }

            val durationMs = System.currentTimeMillis() - startTime
            authMetrics.authCheckDuration(durationMs)

            return response
        }

    @Operation(
        summary = "Обновление сессии",
        operationId = "authRefreshPost",
        description = """Обновляет сессионную cookie.
Требуется валидная существующая сессия.
""",
        responses = [
            ApiResponse(responseCode = "200", description = "Сессия успешно обновлена", content = [Content(schema = Schema(implementation = AuthRefreshToken200Response::class))]),
            ApiResponse(responseCode = "401", description = "Ошибка аутентификации", content = [Content(schema = Schema(implementation = AuthRefreshToken401Response::class))]),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.POST],
        value = ["/auth/refresh"],
        produces = ["application/json"]
    )
        fun authRefreshPost(
            @Parameter(description = "", required = true)
            @Valid @RequestBody request: AuthRefreshRequest
        ): ResponseEntity<Any> {
            val start = System.currentTimeMillis()
            authMetrics.refreshAttempt()

            val result = authService.refreshSession(request)

            authMetrics.refreshDuration(System.currentTimeMillis() - start)

            return when (result) {
                is AuthRefreshToken200Response -> {
                    authMetrics.refreshSuccess()
                    ResponseEntity.ok(result)
        }
            is AuthRefreshToken401Response -> {
                authMetrics.refreshFailure()
                ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(result)
            }
            is InternalServerError -> {
                authMetrics.refreshFailure()
                ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(result)
            }
            else -> {
                authMetrics.refreshFailure()
                ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build()
            }
        }
    }

    @Operation(
        summary = "Вход в систему",
        operationId = "loginUser",
        description = """Аутентификация пользователя по email и паролю.
    Если данные введены верно — создает сессионную cookie и возвращает данные пользователя.
    """,
        responses = [
            ApiResponse(responseCode = "200", description = "Успешный вход", content = [Content(schema = Schema(implementation = LoginUser200Response::class))]),
            ApiResponse(responseCode = "400", description = "Неверный формат или данные", content = [Content(schema = Schema(implementation = LoginUser400Response::class))]),
            ApiResponse(responseCode = "401", description = "Неверные учётные данные", content = [Content(schema = Schema(implementation = LoginUser401Response::class))]),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))])
        ]
    )
    @RequestMapping(
        method = [RequestMethod.POST],
        value = ["/auth/login"],
        produces = ["application/json"],
        consumes = ["application/json"]
    )
    fun loginUser(
        @Parameter(description = "", required = true)
        @Valid @RequestBody loginUserRequest: LoginUserRequest
    ): ResponseEntity<Any> {
        val start = System.currentTimeMillis()
        authMetrics.loginAttempt()

        val response = try {
            authService.loginUser(loginUserRequest)
        } catch (ex: Exception) {
            authMetrics.loginFailure()
            authMetrics.loginDuration(System.currentTimeMillis() - start)
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body(InternalServerError("Ошибка при попытке входа", ex.message ?: "Неизвестная ошибка"))
        }

        val duration = System.currentTimeMillis() - start
        authMetrics.loginDuration(duration)

        return when (response) {
            is UserDto -> {
                val token = jwtService.generateToken(response.email)

                authMetrics.loginSuccess(response.userID.toString())
                ResponseEntity.ok(LoginUser200Response(user = response, accessToken = token))
            }
            is LoginUser400Response -> {
                authMetrics.loginFailure()
                ResponseEntity.badRequest().body(response)
            }
            is LoginUser401Response -> {
                authMetrics.loginFailure()
                ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response)
            }
            else -> {
                authMetrics.loginFailure()
                ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build()
            }
        }
    }

    @Operation(
        summary = "Регистрация нового пользователя",
        operationId = "registerUser",
        description = """Принимает email, имя пользователя и пароль.
        Если email и пароль валидны, отправляет код подтверждения.
        Возвращает временный токен для верификации.
    """,
        responses = [
            ApiResponse(responseCode = "200", description = "Код подтверждения отправлен", content = [Content(schema = Schema(implementation = RegisterUser200Response::class))]),
            ApiResponse(responseCode = "400", description = "Неверный формат данных", content = [Content(schema = Schema(implementation = RegisterUser400Response::class))]),
            ApiResponse(responseCode = "409", description = "Пользователь уже существует", content = [Content(schema = Schema(implementation = RegisterUser409Response::class))]),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))])
        ]
    )
    @RequestMapping(
        method = [RequestMethod.POST],
        value = ["/auth/register"],
        produces = ["application/json"],
        consumes = ["application/json"]
    )
    fun registerUser(
        @Parameter(description = "", required = true)
        @Valid @RequestBody registerUserRequest: RegisterUserRequest
    ): ResponseEntity<Any> {
        val start = System.currentTimeMillis()
        authMetrics.registerAttempt()

        val response = try {
            authService.register(registerUserRequest)
        } catch (ex: Exception) {
            authMetrics.registerFailure()
            authMetrics.registerDuration(System.currentTimeMillis() - start)
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(ex)
        }

        val duration = System.currentTimeMillis() - start
        authMetrics.registerDuration(duration)

        return when (response) {
            is RegisterUser200Response -> {
                authMetrics.registerSuccess()
                ResponseEntity.ok(response)
            }
            is RegisterUser409Response -> {
                authMetrics.registerConflict()
                ResponseEntity.status(HttpStatus.CONFLICT).body(response)
            }
            is RegisterUser400Response -> {
                authMetrics.registerValidationError()
                ResponseEntity.badRequest().body(response)
            }
            is InternalServerError -> {
                authMetrics.registerFailure()
                ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response)
            }
            else -> {
                authMetrics.registerFailure()
                ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build()
            }
        }
    }

    @Operation(
        summary = "Запрос кода для сброса пароля",
        operationId = "requestPasswordReset",
        description = """Отправляет код подтверждения для сброса пароля, если email существует в системе""",
        responses = [
            ApiResponse(responseCode = "200", description = "Код подтверждения отправлен на email", content = [Content(schema = Schema(implementation = RequestPasswordReset200Response::class))]),
            ApiResponse(responseCode = "400", description = "Неверный формат данных", content = [Content(schema = Schema(implementation = RequestPasswordReset400Response::class))]),
            ApiResponse(responseCode = "404", description = "Пользователь с указанным email не найден", content = [Content(schema = Schema(implementation = RequestPasswordReset404Response::class))]),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ]
    )
    @RequestMapping(
        method = [RequestMethod.POST],
        value = ["/auth/forgot-password"],
        produces = ["application/json"],
        consumes = ["application/json"]
    )
    fun requestPasswordReset(@Parameter(description = "", required = true) @Valid @RequestBody request: RequestPasswordResetRequest): ResponseEntity<Any> {
        val start = System.currentTimeMillis()
        authMetrics.passwordResetAttempt()

        return try {
            val result = authService.requestPasswordReset(request)

            val duration = System.currentTimeMillis() - start
            authMetrics.passwordResetDuration(duration)

            when (result) {
                is RequestPasswordReset200Response -> {
                    authMetrics.passwordResetSuccess()
                    ResponseEntity.ok(result)
                }
                is RequestPasswordReset404Response -> {
                    authMetrics.passwordResetFailure()
                    ResponseEntity.status(HttpStatus.NOT_FOUND).body(result)
                }
                is RequestPasswordReset400Response -> {
                    authMetrics.passwordResetFailure()
                    ResponseEntity.badRequest().body(result)
                }
                else -> {
                    authMetrics.passwordResetFailure()
                    ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                        .body(InternalServerError(error = "Ошибка: Неожиданный формат ответа"))
                }
            }
        } catch (ex: Exception) {
            authMetrics.passwordResetFailure()
            ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body(InternalServerError(error = "Ошибка при сбросе пароля: "+ ex.message ?: "Неизвестная ошибка"))
        }
    }

    @Operation(
        summary = "Повторная отправка кода",
        operationId = "resendVerificationCode",
        description = """Отправляет новый код подтверждения""",
        responses = [
            ApiResponse(responseCode = "200", description = "Новый код отправлен", content = [Content(schema = Schema(implementation = ResendVerificationCode200Response::class))]),
            ApiResponse(responseCode = "400", description = "Неверный формат запроса"),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ]
    )
    @RequestMapping(
        method = [RequestMethod.POST],
        value = ["/auth/resend-code"],
        produces = ["application/json"],
        consumes = ["application/json"]
    )
    fun resendVerificationCode(
        @Parameter(description = "Email пользователя", required = true)
        @Valid @RequestBody resendVerificationCodeRequest: ResendVerificationCodeRequest
    ): ResponseEntity<Any> {
        val start = System.currentTimeMillis()
        authMetrics.resendVerificationCodeAttempt()

        val response = try {
            authService.resendVerificationCode(resendVerificationCodeRequest)
        } catch (ex: Exception) {
            authMetrics.resendVerificationCodeFailure()
            authMetrics.resendVerificationCodeDuration(System.currentTimeMillis() - start)
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(InternalServerError(error = ex.message ?: "Internal error"))
        }

        val duration = System.currentTimeMillis() - start
        authMetrics.resendVerificationCodeDuration(duration)

        return when (response) {
            is ResendVerificationCode200Response -> {
                authMetrics.resendVerificationCodeSuccess()
                ResponseEntity.ok(response)
            }
            is InternalServerError -> {
                authMetrics.resendVerificationCodeFailure()
                ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response)
            }
            else -> {
                authMetrics.resendVerificationCodeFailure()
                ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build()
            }
        }
    }

    @Operation(
        summary = "Сброс пароля",
        operationId = "resetPassword",
        description = """Устанавливает новый пароль после подтверждения кода""",
        responses = [
            ApiResponse(responseCode = "200", description = "Пароль изменен", content = [Content(schema = Schema(implementation = ResetPassword200Response::class))]),
            ApiResponse(responseCode = "400", description = "Неверный код или токен", content = [Content(schema = Schema(implementation = ResetPassword400Response::class))]),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ]
    )
    @RequestMapping(
        method = [RequestMethod.POST],
        value = ["/auth/reset-password"],
        produces = ["application/json"],
        consumes = ["application/json"]
    )
    fun resetPassword(
        @Parameter(description = "", required = true)
        @Valid @RequestBody resetPasswordRequest: ResetPasswordRequest
    ): ResponseEntity<Any> {
        val start = System.currentTimeMillis()
        authMetrics.resetPasswordAttempt()

        val response = try {
            authService.resetPassword(resetPasswordRequest)
        } catch (ex: Exception) {
            authMetrics.resetPasswordFailure()
            authMetrics.resetPasswordDuration(System.currentTimeMillis() - start)
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body(InternalServerError("Ошибка при сбросе пароля", ex.message ?: "Неизвестная ошибка"))
        }

        val duration = System.currentTimeMillis() - start
        authMetrics.resetPasswordDuration(duration)

        return when (response) {
            is ResetPassword200Response -> {
                authMetrics.resetPasswordSuccess()
                ResponseEntity.ok(response)
            }
            is ResetPassword400Response -> {
                authMetrics.resetPasswordValidationError()
                ResponseEntity.badRequest().body(response)
            }
            is InternalServerError -> {
                authMetrics.resetPasswordFailure()
                ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response)
            }
            else -> {
                authMetrics.resetPasswordFailure()
                ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Неизвестная ошибка")
            }
        }
    }

    @Operation(
        summary = "Подтверждение email",
        operationId = "verifyEmail",
        description = """Проверяет код подтверждения.
Если код подтверждения верный - создает аккаунт и возвращает данные пользователя.
""",
        responses = [
            ApiResponse(responseCode = "200", description = "Успешная регистрация", content = [Content(schema = Schema(implementation = UserDto::class))]),
            ApiResponse(responseCode = "400", description = "Неверный код или токен", content = [Content(schema = Schema(implementation = VerifyEmail400Response::class))]),
            ApiResponse(responseCode = "410", description = "Истек срок действия кода", content = [Content(schema = Schema(implementation = VerifyEmail410Response::class))]),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ]
    )
    @RequestMapping(
        method = [RequestMethod.POST],
        value = ["/auth/verify"],
        produces = ["application/json"],
        consumes = ["application/json"]
    )
    fun verifyEmail(@Parameter(description = "", required = true) @Valid @RequestBody verifyEmailRequest: VerifyEmailRequest): ResponseEntity<Any> {
        val start = System.currentTimeMillis()
        authMetrics.verifyAttempt()

        val response = try {
            authService.verifyEmail(verifyEmailRequest)
        } catch (ex: Exception) {
            authMetrics.verifyFailure()
            authMetrics.verifyDuration(System.currentTimeMillis() - start)
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body(InternalServerError("Ошибка при подтверждении email", ex.message ?: "Неизвестная ошибка"))
        }

        val duration = System.currentTimeMillis() - start
        authMetrics.verifyDuration(duration)

        return when (response) {
            is UserDto -> {
                authMetrics.verifySuccess(response.userID.toString())
                ResponseEntity.ok(response)
            }
            is VerifyEmail400Response -> {
                authMetrics.verifyValidationError()
                ResponseEntity.badRequest().body(response)
            }
            is VerifyEmail410Response -> {
                authMetrics.verifyExpired()
                ResponseEntity.status(HttpStatus.GONE).body(response)
            }
            else -> {
                authMetrics.verifyFailure()
                ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build()
            }
        }
    }
}
