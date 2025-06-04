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
 * @param tempToken Временный токен из ответа регистрации
 * @param code 6-значный код подтверждения
 */
data class VerifyEmailRequest(

    @Schema(example = "temp_abc123", required = true, description = "Временный токен из ответа регистрации")
    @get:JsonProperty("tempToken", required = true) val tempToken: kotlin.String,

    @get:Pattern(regexp="^\\d{6}$")
    @Schema(example = "123456", required = true, description = "6-значный код подтверждения")
    @get:JsonProperty("code", required = true) val code: kotlin.String
    ) {

}

