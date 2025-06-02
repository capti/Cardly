package ru.vsu.app.dto.requests

import com.fasterxml.jackson.annotation.JsonProperty
import io.swagger.v3.oas.annotations.media.Schema
import jakarta.validation.constraints.NotBlank
import java.time.LocalDateTime

data class NewsRequest(
    @Schema(description = "Заголовок новости", example = "Новое обновление")
    @get:JsonProperty("title", required = true)
    @field:NotBlank
    val title: String,

    @Schema(description = "Содержание новости", example = "Добавлены новые карты")
    @get:JsonProperty("content", required = true)
    @field:NotBlank
    val content: String,

    @Schema(description = "Список изображений")
    @get:JsonProperty("pictures")
    val pictures: List<String>? = null
)
