package ru.vsu.app.dto

import java.util.Objects
import com.fasterxml.jackson.annotation.JsonProperty
import ru.vsu.app.dto.PackDto
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
 * @param questID Уникальный идентификатор квеста
 * @param name Название квеста
 * @param description Описание квеста
 * @param progress Текущий прогресс
 * @param target Целевое значение
 * @param rewardCoins Награда в монетах
 * @param isCompleted Выполнен ли квест
 * @param isClaimed Получена ли награда
 * @param rewardPacks Награда в наборах
 */
data class QuestDto(

    @Schema(example = "1", required = true, description = "Уникальный идентификатор квеста")
    @get:JsonProperty("quest_ID", required = true) val questID: kotlin.Int,

    @Schema(example = "Соберите 5 карт", required = true, description = "Название квеста")
    @get:JsonProperty("name", required = true) val name: kotlin.String,

    @Schema(example = "Соберите 5 карт из коллекции Драконы", required = true, description = "Описание квеста")
    @get:JsonProperty("description", required = true) val description: kotlin.String,

    @Schema(example = "3", required = true, description = "Текущий прогресс")
    @get:JsonProperty("progress", required = true) val progress: kotlin.Int,

    @Schema(example = "5", required = true, description = "Целевое значение")
    @get:JsonProperty("target", required = true) val target: kotlin.Int,

    @Schema(example = "200", required = true, description = "Награда в монетах")
    @get:JsonProperty("rewardCoins", required = true) val rewardCoins: kotlin.Int,

    @Schema(example = "false", required = true, description = "Выполнен ли квест")
    @get:JsonProperty("isCompleted", required = true) val isCompleted: kotlin.Boolean,

    @Schema(example = "false", required = true, description = "Получена ли награда")
    @get:JsonProperty("isClaimed", required = true) val isClaimed: kotlin.Boolean,

    @field:Valid
    @Schema(description = "Награда в наборах")
    @get:JsonProperty("rewardPacks") val rewardPacks: kotlin.collections.List<PackDto>? = null
    ) {

}

