package ru.vsu.app.dto.responses.auth.requestpassword

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
 * @param message 
 */
data class RequestPasswordReset200Response(

    @Schema(example = "reset_xyz789", description = "")
    @get:JsonProperty("resetToken") val resetToken: kotlin.String? = null,

    @Schema(example = "Код подтверждения отправлен на email", description = "")
    @get:JsonProperty("message") val message: kotlin.String? = null
    ) {

}

