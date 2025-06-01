package ru.vsu.app.dto.responses.inventory

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
 * @param newBalance 
 * @param destroyedCardId 
 */
data class InventoryDestroyPost200Response(

    @Schema(example = "2550", description = "")
    @get:JsonProperty("newBalance") val newBalance: kotlin.Int? = null,

    @Schema(example = "501", description = "")
    @get:JsonProperty("destroyedCardId") val destroyedCardId: kotlin.Int? = null
    ) {

}

