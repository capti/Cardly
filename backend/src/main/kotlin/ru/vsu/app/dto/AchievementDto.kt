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
 * @param achievementID Уникальный идентификатор достижения
 * @param name Название достижения
 * @param imageURL Ссылка на изображение
 * @param description Описание достижения
 * @param isUnlocked Статус получения
 */
data class AchievementDto(

    @Schema(example = "101", required = true, description = "Уникальный идентификатор достижения")
    @get:JsonProperty("achievement_ID", required = true) val achievementID: kotlin.Int,

    @Schema(example = "Мастер коллекционирования", required = true, description = "Название достижения")
    @get:JsonProperty("name", required = true) val name: kotlin.String,

    @Schema(example = "https://example.com/achievements/master.png", required = true, description = "Ссылка на изображение")
    @get:JsonProperty("imageURL", required = true) val imageURL: kotlin.String,

    @Schema(example = "Соберите 10 полных коллекций", required = true, description = "Описание достижения")
    @get:JsonProperty("description", required = true) val description: kotlin.String,

    @Schema(example = "false", required = true, description = "Статус получения")
    @get:JsonProperty("isUnlocked", required = true) val isUnlocked: kotlin.Boolean
    ) {

}

