package ru.vsu.app.service

import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.security.crypto.password.PasswordEncoder
import org.springframework.stereotype.Service
import org.springframework.security.core.context.SecurityContextHolder

import ru.vsu.app.dto.requests.ResendVerificationCodeRequest

import ru.vsu.app.dto.responses.auth.login.LoginUser200Response
import ru.vsu.app.dto.responses.auth.login.LoginUser400Response
import ru.vsu.app.dto.responses.auth.login.LoginUser401Response
import ru.vsu.app.dto.requests.LoginUserRequest

import ru.vsu.app.dto.responses.auth.register.RegisterUser200Response
import ru.vsu.app.dto.responses.auth.register.RegisterUser400Response
import ru.vsu.app.dto.responses.auth.register.RegisterUser409Response
import ru.vsu.app.dto.requests.RegisterUserRequest

import ru.vsu.app.dto.responses.auth.verifyemail.VerifyEmail400Response
import ru.vsu.app.dto.responses.auth.verifyemail.VerifyEmail410Response
import ru.vsu.app.dto.responses.auth.verifyemail.ResendVerificationCode200Response
import ru.vsu.app.dto.requests.VerifyEmailRequest

import ru.vsu.app.dto.responses.auth.requestpassword.RequestPasswordReset400Response
import ru.vsu.app.dto.responses.auth.requestpassword.RequestPasswordReset404Response
import ru.vsu.app.dto.responses.auth.requestpassword.RequestPasswordReset200Response
import ru.vsu.app.dto.requests.RequestPasswordResetRequest

import ru.vsu.app.dto.responses.auth.refreshtoken.AuthRefreshToken200Response
import ru.vsu.app.dto.responses.auth.refreshtoken.AuthRefreshToken401Response
import ru.vsu.app.dto.requests.AuthRefreshRequest

import ru.vsu.app.dto.responses.auth.requestpassword.ResetPassword200Response
import ru.vsu.app.dto.responses.auth.requestpassword.ResetPassword400Response
import ru.vsu.app.dto.requests.ResetPasswordRequest

import ru.vsu.app.dto.responses.common.InternalServerError

import ru.vsu.app.dto.UserDto
import ru.vsu.app.dto.CardDto
import ru.vsu.app.dto.AchievementDto

import ru.vsu.app.model.UserEntity

import ru.vsu.app.repository.UserRepository

import ru.vsu.app.service.JwtService
import ru.vsu.app.service.EmailService

import ru.vsu.app.mapper.UserMapper

import kotlin.random.Random

import io.jsonwebtoken.JwtException
import io.jsonwebtoken.ExpiredJwtException

import java.util.regex.Pattern

@Service
class AuthService(
    private val userRepository: UserRepository,
    private val userMapper: UserMapper,
    private val jwtService: JwtService,
    private val emailService: EmailService,
    private val passwordEncoder: PasswordEncoder
) {

    fun getCurrentUser(): UserDto? {
        println(SecurityContextHolder.getContext())
        val authentication = SecurityContextHolder.getContext().authentication

        if (authentication == null || !authentication.isAuthenticated || authentication.principal == "anonymousUser") {
            return null
        }

        val email = authentication.name

        println(email)

        val user = userRepository.findByEmail(email).orElse(null)?: return null

        return userMapper.toDto(user)
    }

    fun register(request: RegisterUserRequest): Any {
        val (email, username, password) = request

        if (userRepository.existsByEmail(email)) {
            return RegisterUser409Response("Пользователь с таким email уже существует")
        }

        if (userRepository.existsByUsername(username)) {
            return RegisterUser409Response("Пользователь с таким username уже существует")
        }

        val activationCode = generateSixDigitCode()

        try {
            emailService.sendActivationEmail(email, activationCode)
        } catch (ex: Exception) {
            ex.printStackTrace()
            return RegisterUser400Response("Ошибка при отправке email. Проверьте корректность адреса")
        }

        val newUser = UserEntity(
            email = email,
            username = username,
            passwordHash = passwordEncoder.encode(password),
            activationToken = activationCode
        )

        userRepository.save(newUser)

        return RegisterUser200Response(
            message = "Пользователь успешно зарегистрирован. Проверьте email для получения кода активации.",
            tempToken = jwtService.generateToken(email)
        )
    }

    // Функция генерации 6-значного кода
    private fun generateSixDigitCode(): String {
        return (100000 + Random.nextInt(900000)).toString()
    }

    fun verifyEmail(request: VerifyEmailRequest): Any {
        val token = request.tempToken

        if (jwtService.isTokenExpired(token)) {
            return VerifyEmail410Response("Срок действия токена истёк")
        }

        val email = jwtService.extractUsername(token)
        val user = userRepository.findByEmail(email).orElse(null)
            ?: return VerifyEmail400Response("Пользователь не найден")

        if (user.isEnabled) {
            return VerifyEmail400Response("Аккаунт уже подтвержден")
        }

        val storedCode = user.activationToken
            ?: return VerifyEmail410Response("Срок действия кода истёк или он уже использован")


        if (storedCode != request.code) {
            return VerifyEmail400Response("Неверный код")
        }

        // всё валидно - активируем аккаунт
        val updatedUser = user.copy(
            isEnabled = true,
            activationToken = null
        )

        userRepository.save(updatedUser)

        return userMapper.toDto(updatedUser)
    }

    fun resendVerificationCode(request: ResendVerificationCodeRequest): Any {
        val token = request.tempToken

        val email = jwtService.extractUsernameIgnoreExpiration(token)
        ?: return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Invalid token")

        val user = userRepository.findByEmail(email).orElse(null)
        ?: return ResponseEntity.status(HttpStatus.BAD_REQUEST)

        if (user.isEnabled) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
        }

        val newActivationCode = generateSixDigitCode()

        try {
            emailService.sendActivationEmail(email, newActivationCode)
        } catch (ex: Exception) {
            ex.printStackTrace()
            return InternalServerError(error = "Ошибка при отправке email. Проверьте корректность адреса")
        }

        val updatedUser = user.copy(
            activationToken = newActivationCode
        )

        userRepository.save(updatedUser)

        val newTempToken = jwtService.generateToken(email)

        return ResendVerificationCode200Response(
            message = "Новый код подтверждения отправлен",
            tempToken = newTempToken
        )
    }

    fun loginUser(request: LoginUserRequest): Any {
        val emailPattern = Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")
        if (!emailPattern.matcher(request.email).matches() || request.password.length < 6) {
            return LoginUser400Response(
                error = "Неверный формат email или пароль слишком короткий"
            )
        }

        return try {
            val userEntity = userRepository.findByEmail(request.email).orElse(null)
            if (userEntity == null) {
                return LoginUser401Response(
                    error = "Неверные учётные данные"
                )
            }

            if (!userEntity.isEnabled) {
                return LoginUser401Response(
                    error = "Аккаунт не активирован"
                )
            }

            if (!passwordEncoder.matches(request.password, userEntity.passwordHash)) {
                return LoginUser401Response(
                    error = "Неверные учётные данные"
                )
            }

            userMapper.toDto(userEntity)
        } catch (ex: Exception) {
            InternalServerError(
                error = "Ошибка при попытке входа: ${ex.message ?: "Неизвестная ошибка"}"
            )
        }
    }

    fun refreshSession(
        request: AuthRefreshRequest
    ): Any {
        return try {
            val isExpired = jwtService.isTokenExpired(request.accessToken)
            if (isExpired) {
                return AuthRefreshToken401Response(false, "Access token истёк")
            }
            val accessToken = request.accessToken

            val email = jwtService.extractUsername(accessToken)

            val user = userRepository.findByEmail(email).orElse(null)
                ?: return AuthRefreshToken401Response(false, "Пользователь не найден")

            val newAccessToken = jwtService.generateToken(email)

            AuthRefreshToken200Response(accessToken = newAccessToken)

        } catch (ex: JwtException) {
            AuthRefreshToken401Response(false, "Невалидный или просроченный access token")
        } catch (ex: Exception) {
            InternalServerError(error = "Ошибка при обновлении токена: " + ex.message ?: "Неизвестная ошибка")
        }
    }

    fun requestPasswordReset(request: RequestPasswordResetRequest): Any {
        val emailPattern = Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")
        if (!emailPattern.matcher(request.email).matches()) {
            return RequestPasswordReset400Response(
                error = "Неверный формат email или пароль слишком короткий"
            )
        }

        val user = userRepository.findByEmail(request.email)
            ?: return RequestPasswordReset404Response("Пользователь с таким email не зарегистрирован")

        val code = generateSixDigitCode()
        val resetToken = jwtService.generatePasswordResetToken(request.email, code)

        emailService.sendPasswordResetEmail(request.email, code)

        return RequestPasswordReset200Response(
            resetToken = resetToken,
            message = "Код подтверждения отправлен на email"
        )
    }


    fun resetPassword(request: ResetPasswordRequest): Any {
        try {
            val payload = jwtService.parseResetToken(request.resetToken)

            if (request.code != payload.code) {
                return ResetPassword400Response("Неверный код подтверждения")
            }

            val user = userRepository.findByEmail(payload.email).orElse(null)
                ?: return ResetPassword400Response("Пользователь не найден")

            val updatedUser = user.copy(passwordHash = passwordEncoder.encode(request.newPassword))
            userRepository.save(updatedUser)

            return ResetPassword200Response("Пароль успешно изменен")

        } catch (ex: ExpiredJwtException) {
            return ResetPassword400Response("Срок действия токена истёк")
        } catch (ex: JwtException) {
            return ResetPassword400Response("Невалидный токен")
        } catch (ex: Exception) {
            ex.printStackTrace()
            return InternalServerError("Ошибка сброса пароля: ${ex.message}")
        }
    }


}
