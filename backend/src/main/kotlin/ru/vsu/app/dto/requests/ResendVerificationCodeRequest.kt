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
 * @param tempToken 
 */
data class ResendVerificationCodeRequest(

    @Schema(example = "temp_abc123", required = true, description = "")
    @get:JsonProperty("tempToken", required = true) val tempToken: kotlin.String
    ) {

}

