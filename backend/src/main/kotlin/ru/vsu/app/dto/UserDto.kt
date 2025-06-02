package ru.vsu.app.dto

import java.util.Objects
import com.fasterxml.jackson.annotation.JsonProperty
import ru.vsu.app.dto.AchievementDto
import ru.vsu.app.dto.CardDto
import ru.vsu.app.dto.NotificationDto
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
 * @param userID Уникальный идентификатор
 * @param username Имя пользователя
 * @param email Электронная почта
 * @param password Пароль
 * @param inventoryCards Карты в инвентаре
 * @param balance Баланс
 * @param achievements Достижения
 * @param favoriteCards Избранные карты
 * @param onChange Карты на обмен
 * @param avatarUrl Аватар пользователя
 * @param favoriteAchievements Избранные достижения
 * @param notifications Уведомления
 */
data class UserDto(

    @Schema(example = "1", required = true, description = "Уникальный идентификатор")
    @get:JsonProperty("user_id", required = true) val userID: kotlin.Int,

    @Schema(example = "Коллекционер_123", required = true, description = "Имя пользователя")
    @get:JsonProperty("username", required = true) val username: kotlin.String,

    @get:Email
    @Schema(example = "user@example.com", required = true, description = "Электронная почта")
    @get:JsonProperty("email", required = true) val email: kotlin.String,


    @field:Valid
    @Schema(required = true, description = "Карты в инвентаре")
    @get:JsonProperty("inventoryCards", required = true) val inventoryCards: kotlin.collections.List<CardDto>,

    @Schema(example = "2500", required = true, description = "Баланс")
    @get:JsonProperty("balance", required = true) val balance: kotlin.Int,

    @field:Valid
    @Schema(required = true, description = "Достижения")
    @get:JsonProperty("achievements", required = true) val achievements: kotlin.collections.List<AchievementDto>,

    @field:Valid
    @Schema(description = "Избранные карты")
    @get:JsonProperty("favoriteCards") val favoriteCards: kotlin.collections.List<CardDto>? = null,

    @field:Valid
    @Schema(description = "Карты на обмен")
    @get:JsonProperty("onChange") val onChange: kotlin.collections.List<CardDto>? = null,

    @Schema(example = "https://example.com/avatars/user1.png", description = "Аватар пользователя")
    @get:JsonProperty("avatar_url") val avatarUrl: kotlin.String? = null,

    @field:Valid
    @Schema(description = "Избранные достижения")
    @get:JsonProperty("favoriteAchievements") val favoriteAchievements: kotlin.collections.List<AchievementDto>? = null,

    @field:Valid
    @Schema(description = "Уведомления")
    @get:JsonProperty("notifications") val notifications: kotlin.collections.List<NotificationDto>? = null
    ) {

}

