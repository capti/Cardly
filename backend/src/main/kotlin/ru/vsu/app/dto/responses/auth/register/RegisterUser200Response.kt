package ru.vsu.app.dto.responses.auth.register

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
 * @param tempToken 
 * @param message 
 */
data class RegisterUser200Response(

    @Schema(example = "temp_abc123", description = "")
    @get:JsonProperty("tempToken") val tempToken: kotlin.String? = null,

    @Schema(example = "Код подтверждения отправлен на email", description = "")
    @get:JsonProperty("message") val message: kotlin.String? = null
)

