package ru.vsu.app.dto.requests

import java.util.Objects
import com.fasterxml.jackson.annotation.JsonProperty
import jakarta.validation.constraints.DecimalMax
import jakarta.validation.constraints.DecimalMin
import jakarta.validation.constraints.Email
import jakarta.validation.constraints.Max
import jakarta.validation.constraints.Min
import jakarta.validation.constraints.NotNull
import jakarta.validation.constraints.Pattern
import jakarta.validation.constraints.Size
import jakarta.validation.Valid
import io.swagger.v3.oas.annotations.media.Schema

/**
 * 
 * @param email Email пользователя
 * @param username Имя пользователя (3-25 символов)
 * @param password Пароль (минимум 8 символов)
 */
data class RegisterUserRequest(

    @get:Email
    @Schema(example = "user@example.com", required = true, description = "Email пользователя")
    @get:JsonProperty("email", required = true) val email: kotlin.String,

    @get:Size(min=3,max=25)
    @Schema(example = "Коллекционер_123", required = true, description = "Имя пользователя (3-25 символов)")
    @get:JsonProperty("username", required = true) val username: kotlin.String,

    @get:Size(min=8)
    @Schema(example = "Password123!", required = true, description = "Пароль (минимум 8 символов)")
    @get:JsonProperty("password", required = true) val password: kotlin.String
    ) {

}

