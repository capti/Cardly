package ru.vsu.app.dto.responses.trades

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
data class TradesTradeIdAcceptPost200Response(

    @Schema(example = "Обмен успешно завершен", description = "")
    @get:JsonProperty("message") val message: kotlin.String? = null
    ) {

}

