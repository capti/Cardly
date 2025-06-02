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
 * @param notificationID Уникальный идентификатор уведомления
 * @param userID Уникальный идентификатор пользователя
 * @param message Текст уведомления
 * @param notificationDateTime Дата и время уведомления
 * @param links Ссылка на подробности обмена
 */
data class NotificationDto(

    @Schema(example = "201", required = true, description = "Уникальный идентификатор уведомления")
    @get:JsonProperty("notification_ID", required = true) val notificationID: kotlin.Int,

    @Schema(example = "1", required = true, description = "Уникальный идентификатор пользователя")
    @get:JsonProperty("user_id", required = true) val userID: kotlin.Int,

    @Schema(example = "Ваша карта была успешно обменяна", required = true, description = "Текст уведомления")
    @get:JsonProperty("message", required = true) val message: kotlin.String,

    @Schema(example = "2024-05-20T15:30Z", required = true, description = "Дата и время уведомления")
    @get:JsonProperty("notificationDateTime", required = true) val notificationDateTime: java.time.LocalDateTime,

    @Schema(example = "[\"https://example.com/exchange-details\"]", description = "Ссылка на подробности обмена")
    @get:JsonProperty("links") val links: kotlin.collections.List<kotlin.String>? = null
    ) {

}

