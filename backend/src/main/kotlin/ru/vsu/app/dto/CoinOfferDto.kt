package ru.vsu.app.dto

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
 * @param offerId 
 * @param name 
 * @param coinsAmount 
 * @param price 
 * @param imageUrl 
 * @param description 
 */
data class CoinOfferDto(

    @Schema(example = "1", description = "")
    @get:JsonProperty("offer_id") val offerId: kotlin.Int? = null,

    @Schema(example = "Стартовый набор", description = "")
    @get:JsonProperty("name") val name: kotlin.String? = null,

    @Schema(example = "100", description = "")
    @get:JsonProperty("coinsAmount") val coinsAmount: kotlin.Int? = null,

    @Schema(example = "99.9", description = "")
    @get:JsonProperty("price") val price: kotlin.Double? = null,

    @field:Valid
    @Schema(description = "")
    @get:JsonProperty("imageUrl") val imageUrl: java.net.URI? = null,

    @Schema(example = "Стартовый набор. Вы можете получить...", description = "")
    @get:JsonProperty("description") val description: kotlin.String? = null
    ) {

}

