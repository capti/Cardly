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
 * @param newsID Уникальный идентификатор новости
 * @param title Заголовок новости
 * @param content Содержание новости
 * @param datePosted Дата публикации
 * @param pictures Ссылки на изображения
 */
data class NewsDto(

    @Schema(example = "1", required = true, description = "Уникальный идентификатор новости")
    @get:JsonProperty("news_ID", required = true) val newsID: kotlin.Int,

    @Schema(example = "Новое обновление системы", required = true, description = "Заголовок новости")
    @get:JsonProperty("title", required = true) val title: kotlin.String,

    @Schema(example = "Мы добавили новые карты в коллекцию", required = true, description = "Содержание новости")
    @get:JsonProperty("content", required = true) val content: kotlin.String,

    @Schema(example = "2024-05-20T14:48Z", required = true, description = "Дата публикации")
    @get:JsonProperty("datePosted", required = true) val datePosted: java.time.LocalDateTime,

    @Schema(example = "[\"https://example.com/news1.jpg\",\"https://example.com/news2.jpg\"]", description = "Ссылки на изображения")
    @get:JsonProperty("pictures") val pictures: kotlin.collections.List<kotlin.String>? = null
    ) {

}

