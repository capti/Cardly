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
 * @param resetToken 
 * @param code 
 * @param newPassword 
 */
data class ResetPasswordRequest(

    @Schema(example = "reset_xyz789", required = true, description = "")
    @get:JsonProperty("resetToken", required = true) val resetToken: kotlin.String,

    @get:Pattern(regexp="^\\d{6}$")
    @Schema(example = "654321", required = true, description = "")
    @get:JsonProperty("code", required = true) val code: kotlin.String,

    @get:Size(min=8)
    @Schema(example = "NewSecurePass123!", required = true, description = "")
    @get:JsonProperty("newPassword", required = true) val newPassword: kotlin.String
    ) {

}

