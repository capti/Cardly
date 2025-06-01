package ru.vsu.app.dto.responses.auth.verifyemail

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
 * @param message 
 */
data class ResendVerificationCode200Response(

    @Schema(example = "Новый код подтверждения отправлен", description = "")
    @get:JsonProperty("message") val message: kotlin.String? = null,
    @Schema(example = "Новый временный токен", description = "")
    @get:JsonProperty("tempToken") val tempToken: kotlin.String? = null
    ) {

}

