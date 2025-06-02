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
 * @param notificationsEnabled Включены ли уведомления
 * @param showInventory Виден ли инвентарь другим пользователям
 * @param autoDeclineTrades Автоматически отклонять все входящие предложения обмена
 */
data class UserSettingsDto(

    @Schema(example = "true", required = true, description = "Включены ли уведомления")
    @get:JsonProperty("notificationsEnabled", required = true) val notificationsEnabled: kotlin.Boolean,

    @Schema(example = "false", required = true, description = "Виден ли инвентарь другим пользователям")
    @get:JsonProperty("showInventory", required = true) val showInventory: kotlin.Boolean,

    @Schema(example = "false", required = true, description = "Автоматически отклонять все входящие предложения обмена")
    @get:JsonProperty("autoDeclineTrades", required = true) val autoDeclineTrades: kotlin.Boolean
    ) {

}

