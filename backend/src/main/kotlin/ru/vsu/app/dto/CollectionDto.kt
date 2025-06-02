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
 * @param collectionID Уникальный идентификатор коллекции
 * @param name Название коллекции
 * @param cards Карты в коллекции
 * @param imageURL Обложка коллекции
 */
data class CollectionDto(

    @Schema(example = "801", required = true, description = "Уникальный идентификатор коллекции")
    @get:JsonProperty("collection_ID", required = true) val collectionID: kotlin.Int,

    @Schema(example = "Драконы", required = true, description = "Название коллекции")
    @get:JsonProperty("name", required = true) val name: kotlin.String,

    @field:Valid
    @Schema(required = true, description = "Карты в коллекции")
    @get:JsonProperty("cards", required = true) val cards: kotlin.collections.List<CardDto>,

    @Schema(example = "https://example.com/collections/dragons.png", required = true, description = "Обложка коллекции")
    @get:JsonProperty("imageURL", required = true) val imageURL: kotlin.String
    ) {

}

