package ru.vsu.app.dto.responses.auth

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
 * @param isAuthenticated 
 * @param message 
 */
data class AuthCheckGet401Response(

    @Schema(example = "false", description = "")
    @get:JsonProperty("isAuthenticated") val isAuthenticated: kotlin.Boolean? = null,

    @Schema(example = "Требуется авторизация", description = "")
    @get:JsonProperty("message") val message: kotlin.String? = null
    ) {

}

