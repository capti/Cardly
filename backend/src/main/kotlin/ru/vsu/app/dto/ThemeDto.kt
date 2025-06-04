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
 * @param themeID Уникальный идентификатор темы
 * @param name Название темы
 * @param description Описание темы
 */
data class ThemeDto(

    @Schema(example = "901", required = true, description = "Уникальный идентификатор темы")
    @get:JsonProperty("theme_ID", required = true) val themeID: kotlin.Int,

    @Schema(example = "Мифические существа", required = true, description = "Название темы")
    @get:JsonProperty("name", required = true) val name: kotlin.String,

    @Schema(example = "Создайте изображение мифического существа", description = "Описание темы")
    @get:JsonProperty("description") val description: kotlin.String? = null
    ) {

}

