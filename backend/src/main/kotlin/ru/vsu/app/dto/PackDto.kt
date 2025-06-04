package ru.vsu.app.dto

import java.util.Objects
import com.fasterxml.jackson.annotation.JsonProperty
import ru.vsu.app.dto.CardDto
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
 * @param packID Уникальный идентификатор набора
 * @param name Название набора
 * @param imageURL Ссылка на изображение
 * @param cards Карты в наборе
 * @param price Цена
 */
data class PackDto(

    @Schema(example = "401", required = true, description = "Уникальный идентификатор набора")
    @get:JsonProperty("pack_ID", required = true) val packID: kotlin.Int,

    @Schema(example = "Стартовый набор", required = true, description = "Название набора")
    @get:JsonProperty("name", required = true) val name: kotlin.String,

    @Schema(example = "https://example.com/packs/starter.png", required = true, description = "Ссылка на изображение")
    @get:JsonProperty("imageURL", required = true) val imageURL: kotlin.String,

    @field:Valid
    @Schema(required = true, description = "Карты в наборе")
    @get:JsonProperty("cards", required = true) val cards: kotlin.collections.List<CardDto>,

    @Schema(example = "1000", required = true, description = "Цена")
    @get:JsonProperty("price", required = true) val price: kotlin.Int
    ) {

}

