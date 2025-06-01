package ru.vsu.app.dto.responses.home

import com.fasterxml.jackson.annotation.JsonProperty
import io.swagger.v3.oas.annotations.media.Schema
import java.time.LocalDateTime

data class NewsResponse(
    @Schema(description = "ID новости")
    @get:JsonProperty("id")
    val id: Int,

    @Schema(description = "Заголовок новости")
    @get:JsonProperty("title")
    val title: String,

    @Schema(description = "Содержание новости")
    @get:JsonProperty("content")
    val content: String,

    @Schema(description = "Дата создания")
    @get:JsonProperty("createdAt")
    val createdAt: LocalDateTime,

    @Schema(description = "Дата обновления")
    @get:JsonProperty("updatedAt")
    val updatedAt: LocalDateTime,

    @Schema(description = "Список изображений")
    @get:JsonProperty("pictures")
    val pictures: List<String>? = null
)
