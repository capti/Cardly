package ru.vsu.app.dto.responses.inventory

import java.util.Objects
import com.fasterxml.jackson.annotation.JsonProperty

import ru.vsu.app.dto.CardDto
import ru.vsu.app.dto.CollectionDto

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
 * @param inventory 
 * @param favoriteCards ID избранных карт
 * @param collections 
 * @param balance 
 */
data class InventoryGet200Response(

    @field:Valid
    @Schema(description = "")
    @get:JsonProperty("inventory") val inventory: kotlin.collections.List<CardDto>? = null,

    @Schema(description = "ID избранных карт")
    @get:JsonProperty("favoriteCards") val favoriteCards: kotlin.collections.List<kotlin.Int>? = null,

    @field:Valid
    @Schema(description = "")
    @get:JsonProperty("collections") val collections: kotlin.collections.List<CollectionDto>? = null,

    @Schema(example = "2500", description = "")
    @get:JsonProperty("balance") val balance: kotlin.Int? = null
    ) {

}

