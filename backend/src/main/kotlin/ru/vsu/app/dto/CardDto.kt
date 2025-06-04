package ru.vsu.app.dto

import com.fasterxml.jackson.annotation.JsonCreator
import com.fasterxml.jackson.annotation.JsonProperty
import com.fasterxml.jackson.annotation.JsonValue
import io.swagger.v3.oas.annotations.media.Schema
import jakarta.validation.Valid

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
    @get:JsonProperty("card_ID", required = true) val cardID: Int,

    @Schema(example = "Ледяной феникс", required = true, description = "Название карты")
    @get:JsonProperty("name", required = true) val name: String,

    @Schema(example = "https://example.com/cards/pheonix.png", required = true, description = "Ссылка на изображение")
    @get:JsonProperty("imageURL", required = true) val imageURL: String,

    @Schema(example = "Редкая", required = true, description = "Редкость карты")
    @get:JsonProperty("rarity", required = true) val rarity: Rarity,

    @Schema(example = "50", required = true, description = "Минимальная цена - используется для разбора карточки")
    @get:JsonProperty("min_price", required = true) val minPrice: Int,

    @Schema(example = "false", required = true, description = "Флаг показывающий сгенерированная ли карта")
    @get:JsonProperty("isGenerated", required = true) val isGenerated: Boolean,

    @Schema(example = "Ледяной Феникс — это мифическое существо...", description = "Описание карты")
    @get:JsonProperty("description") val description: String? = null,

    @field:Valid
    @Schema(description = "Тематика, на которую была сгенерирована карта (только для уникальных карт)")
    @get:JsonProperty("theme") val theme: ThemeDto? = null
) {
    enum class Rarity(@get:JsonValue val value: String) {
        Обычная("Обычная"),
        Редкая("Редкая"),
        Эпическая("Эпическая"),
        Легендарная("Легендарная"),
        Уникальная("Уникальная");

        companion object {
            @JvmStatic
            @JsonCreator
            fun forValue(value: String): Rarity {
                return values().first { it.value == value }
            }
        }
    }
}
