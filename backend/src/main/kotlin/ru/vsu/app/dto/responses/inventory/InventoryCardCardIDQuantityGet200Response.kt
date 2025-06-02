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
 * @param count 
 * @param canDisassemble 
 * @param canTrade 
 */
data class InventoryCardCardIDQuantityGet200Response(

    @Schema(example = "3", description = "")
    @get:JsonProperty("count") val count: kotlin.Int? = null,

    @Schema(example = "true", description = "")
    @get:JsonProperty("canDisassemble") val canDisassemble: kotlin.Boolean? = null,

    @Schema(example = "true", description = "")
    @get:JsonProperty("canTrade") val canTrade: kotlin.Boolean? = null
    ) {

}

