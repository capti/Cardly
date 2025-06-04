package ru.vsu.app.dto.responses.shop

import java.util.Objects
import com.fasterxml.jackson.annotation.JsonProperty
import ru.vsu.app.model.CardEntity
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
 * @param receivedCards Карты, полученные из набора
 * @param newCardsAdded Были ли карты успешно добавлены в инвентарь
 */
data class ShopPacksPackIdOpenPost200Response(

    @field:Valid
    @Schema(description = "Карты, полученные из набора")
    @get:JsonProperty("receivedCards") val receivedCards: kotlin.collections.List<CardEntity>? = null,

    @Schema(example = "true", description = "Были ли карты успешно добавлены в инвентарь")
    @get:JsonProperty("newCardsAdded") val newCardsAdded: kotlin.Boolean? = null
    ) {

}

