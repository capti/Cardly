package ru.vsu.app.dto

import io.swagger.v3.oas.annotations.media.Schema

@Schema(description = "Запрос на вход в систему")
data class LoginRequest(
    @Schema(description = "Email пользователя", example = "user@example.com")
    val email: String,
    
    @Schema(description = "Пароль пользователя", example = "password123")
    val password: String
)

@Schema(description = "Ответ на успешный вход в систему")
data class LoginResponse(
    @Schema(description = "JWT токен для авторизации", example = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...")
    val token: String,
    
    @Schema(description = "Имя пользователя", example = "johndoe")
    val username: String,
    
    @Schema(description = "Email пользователя", example = "user@example.com")
    val email: String
)

@Schema(description = "Запрос на регистрацию нового пользователя")
data class RegisterRequest(
    @Schema(description = "Email пользователя", example = "user@example.com")
    val email: String,
    
    @Schema(description = "Имя пользователя", example = "johndoe")
    val username: String,
    
    @Schema(description = "Пароль пользователя", example = "password123")
    val password: String
)

@Schema(description = "Ответ на запрос регистрации")
data class RegisterResponse(
    @Schema(description = "Сообщение о результате операции", example = "Пользователь успешно зарегистрирован")
    val message: String,
    
    @Schema(description = "Флаг успешности операции", example = "true")
    val success: Boolean
)

@Schema(description = "Запрос на сброс пароля")
data class ForgotPasswordRequest(
    @Schema(description = "Email пользователя", example = "user@example.com")
    val email: String
)

@Schema(description = "Запрос на верификацию кода сброса пароля")
data class ResetPasswordRequest(
    @Schema(description = "Код подтверждения", example = "123456")
    val token: String,
    
    @Schema(description = "Новый пароль", example = "newPassword123")
    val newPassword: String
)

@Schema(description = "Запрос на активацию аккаунта по коду")
data class ActivateAccountRequest(
    @Schema(description = "Email пользователя", example = "user@example.com")
    val email: String,
    
    @Schema(description = "Код активации", example = "123456")
    val code: String
)

@Schema(description = "Информация о пользователе")
data class UserInfoResponse(
    @Schema(description = "Идентификатор пользователя", example = "1")
    val id: Long,
    
    @Schema(description = "Имя пользователя", example = "johndoe")
    val username: String,
    
    @Schema(description = "Email пользователя", example = "user@example.com")
    val email: String
)

@Schema(description = "Стандартный ответ API")
data class ApiResponse(
    @Schema(description = "Сообщение о результате операции", example = "Операция выполнена успешно")
    val message: String,
    
    @Schema(description = "Флаг успешности операции", example = "true")
    val success: Boolean
) 