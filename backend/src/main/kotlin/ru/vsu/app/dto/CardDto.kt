package ru.vsu.app.dto

import java.util.Objects
import com.fasterxml.jackson.annotation.JsonCreator
import com.fasterxml.jackson.annotation.JsonProperty
import com.fasterxml.jackson.annotation.JsonValue
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
 * @param cardID Уникальный идентификатор карты
 * @param name Название карты
 * @param imageURL Ссылка на изображение
 * @param rarity Редкость карты
 * @param minPrice Минимальная цена - используется для разбора карточки
 * @param isGenerated Флаг показывающий сгенерированная ли карта (true для уникальных, false для остальных)
 * @param description Описание карты
 * @param theme Тематика, на которую была сгенерирвана карта (только для уникальных карт)
 */
data class CardDto(

    @Schema(example = "501", required = true, description = "Уникальный идентификатор карты")
    @get:JsonProperty("card_ID", required = true) val cardID: kotlin.Int,

    @Schema(example = "Ледяной феникс", required = true, description = "Название карты")
    @get:JsonProperty("name", required = true) val name: kotlin.String,

    @Schema(example = "https://example.com/cards/pheonix.png", required = true, description = "Ссылка на изображение")
    @get:JsonProperty("imageURL", required = true) val imageURL: kotlin.String,

    @Schema(example = "Редкая", required = true, description = "Редкость карты")
    @get:JsonProperty("rarity", required = true) val rarity: CardDto.Rarity,

    @Schema(example = "50", required = true, description = "Минимальная цена - используется для разбора карточки")
    @get:JsonProperty("min_price", required = true) val minPrice: kotlin.Int,

    @Schema(example = "false", required = true, description = "Флаг показывающий сгенерированная ли карта (true для уникальных, false для остальных)")
    @get:JsonProperty("isGenerated", required = true) val isGenerated: kotlin.Boolean,

    @Schema(example = "Ледяной Феникс — это мифическое существо, воплощающее силу зимы и вечного обновления. Его перья сверкают как морозный утренний иней, а глаза светятся холодным синим светом.", description = "Описание карты")
    @get:JsonProperty("description") val description: kotlin.String? = null,

    @Schema(example = "Мифическое существо", description = "Тематика, на которую была сгенерирвана карта (только для уникальных карт)")
    @get:JsonProperty("theme") val theme: kotlin.String? = null
    ) {

    /**
    * Редкость карты
    * Values: Обычная,Редкая,Эпическая,Легендарная,Уникальная
    */
    enum class Rarity(@get:JsonValue val value: kotlin.String) {

        Обычная("Обычная"),
        Редкая("Редкая"),
        Эпическая("Эпическая"),
        Легендарная("Легендарная"),
        Уникальная("Уникальная");

        companion object {
            @JvmStatic
            @JsonCreator
            fun forValue(value: kotlin.String): Rarity {
                return values().first{it -> it.value == value}
            }
        }
    }

}

