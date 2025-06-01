package ru.vsu.app.dto.responses.common

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
 * @param error 
 * @param code 
 * @param timestamp 
 */
data class InternalServerError(
    @Schema(example = "Что-то пошло не так, попробуйте позже", description = "")
    @get:JsonProperty("error") val error: kotlin.String? = null,

    @Schema(example = "INTERNAL_SERVER_ERROR", description = "")
    @get:JsonProperty("code") val code: kotlin.String? = null,

    @Schema(example = "2024-05-20T12:00Z", description = "")
    @get:JsonProperty("timestamp") val timestamp: java.time.LocalDateTime? = null
)
