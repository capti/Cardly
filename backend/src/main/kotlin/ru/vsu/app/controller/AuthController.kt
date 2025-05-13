package ru.vsu.app.controller

import io.swagger.v3.oas.annotations.Operation
import io.swagger.v3.oas.annotations.media.Content
import io.swagger.v3.oas.annotations.media.Schema
import io.swagger.v3.oas.annotations.responses.ApiResponse as SwaggerApiResponse
import io.swagger.v3.oas.annotations.responses.ApiResponses
import io.swagger.v3.oas.annotations.tags.Tag
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.security.core.annotation.AuthenticationPrincipal
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.web.bind.annotation.*
import ru.vsu.app.dto.*
import ru.vsu.app.service.UserService

@RestController
@RequestMapping("/api/auth")
@Tag(name = "Аутентификация", description = "API для регистрации, входа и управления аккаунтом")
class AuthController(private val userService: UserService) {

    @Operation(summary = "Регистрация нового пользователя")
    @ApiResponses(value = [
        SwaggerApiResponse(responseCode = "200", description = "Пользователь успешно зарегистрирован"),
        SwaggerApiResponse(responseCode = "400", description = "Некорректные данные или пользователь уже существует")
    ])
    @PostMapping("/register")
    fun register(@RequestBody request: RegisterRequest): ResponseEntity<RegisterResponse> {
        val response = userService.register(request)
        return if (response.success) {
            ResponseEntity.ok(response)
        } else {
            ResponseEntity.badRequest().body(response)
        }
    }

    @Operation(summary = "Активация аккаунта по коду")
    @ApiResponses(value = [
        SwaggerApiResponse(responseCode = "200", description = "Аккаунт успешно активирован"),
        SwaggerApiResponse(responseCode = "400", description = "Неверный код активации")
    ])
    @PostMapping("/activate")
    fun activateAccount(@RequestBody request: ActivateAccountRequest): ResponseEntity<ApiResponse> {
        val response = userService.activateAccount(request)
        return if (response.success) {
            ResponseEntity.ok(response)
        } else {
            ResponseEntity.badRequest().body(response)
        }
    }

    @Operation(summary = "Вход в систему")
    @ApiResponses(value = [
        SwaggerApiResponse(
            responseCode = "200", 
            description = "Успешная аутентификация, возвращает JWT токен",
            content = [Content(schema = Schema(implementation = LoginResponse::class))]
        ),
        SwaggerApiResponse(
            responseCode = "401", 
            description = "Неверные учетные данные",
            content = [Content(schema = Schema(implementation = ApiResponse::class))]
        )
    ])
    @PostMapping("/login")
    fun login(@RequestBody request: LoginRequest): ResponseEntity<Any> {
        val response = userService.login(request)
        return if (response != null) {
            ResponseEntity.ok(response)
        } else {
            ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                .body(ApiResponse("Неверные учетные данные или аккаунт не активирован", false))
        }
    }

    @Operation(summary = "Получение информации о текущем пользователе")
    @ApiResponses(value = [
        SwaggerApiResponse(
            responseCode = "200", 
            description = "Информация о пользователе",
            content = [Content(schema = Schema(implementation = UserInfoResponse::class))]
        ),
        SwaggerApiResponse(responseCode = "401", description = "Неавторизованный доступ")
    ])
    @GetMapping("/user-info")
    fun getUserInfo(@AuthenticationPrincipal userDetails: UserDetails): ResponseEntity<UserInfoResponse> {
        val response = userService.getUserInfo(userDetails.username)
        return ResponseEntity.ok(response)
    }

    @Operation(summary = "Запрос на сброс пароля")
    @ApiResponses(value = [
        SwaggerApiResponse(
            responseCode = "200", 
            description = "Код для сброса пароля отправлен на email",
            content = [Content(schema = Schema(implementation = ApiResponse::class))]
        )
    ])
    @PostMapping("/forgot-password")
    fun forgotPassword(@RequestBody request: ForgotPasswordRequest): ResponseEntity<ApiResponse> {
        val response = userService.forgotPassword(request)
        return ResponseEntity.ok(response)
    }
    
    @Operation(summary = "Установка нового пароля по коду из email")
    @ApiResponses(value = [
        SwaggerApiResponse(
            responseCode = "200", 
            description = "Пароль успешно изменен",
            content = [Content(schema = Schema(implementation = ApiResponse::class))]
        ),
        SwaggerApiResponse(
            responseCode = "400", 
            description = "Неверный код или код устарел",
            content = [Content(schema = Schema(implementation = ApiResponse::class))]
        )
    ])
    @PostMapping("/reset-password")
    fun resetPassword(@RequestBody request: ResetPasswordRequest): ResponseEntity<ApiResponse> {
        val response = userService.resetPassword(request)
        return if (response.success) {
            ResponseEntity.ok(response)
        } else {
            ResponseEntity.badRequest().body(response)
        }
    }
} 