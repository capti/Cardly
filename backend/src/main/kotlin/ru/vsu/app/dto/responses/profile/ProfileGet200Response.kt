package ru.vsu.app.dto.responses.profile

import com.fasterxml.jackson.annotation.JsonProperty
import ru.vsu.app.model.AchievementEntity
import ru.vsu.app.model.CardEntity
import ru.vsu.app.model.UserStatsEntity
import jakarta.validation.Valid
import jakarta.validation.constraints.Size
import io.swagger.v3.oas.annotations.media.Schema

/**
 * 
 * @param userStats 
 * @param favoriteCards 
 * @param favoriteAchievements 
 * @param userID ID пользователя
 * @param username Имя пользователя
 * @param avatarUrl Ссылка на аватар пользователя
 */
data class ProfileGet200Response(

    @field:Valid
    @Schema(description = "")
    @get:JsonProperty("userStats") val userStats: UserStatsEntity? = null,

    @field:Valid
    @field:Size(max = 5)
    @Schema(description = "")
    @get:JsonProperty("favoriteCards") val favoriteCards: List<CardEntity>? = null,

    @field:Valid
    @field:Size(max = 4)
    @Schema(description = "")
    @get:JsonProperty("favoriteAchievements") val favoriteAchievements: List<AchievementEntity>? = null,

    @Schema(example = "123", description = "ID пользователя")
    @get:JsonProperty("user_id") val userID: Int? = null,

    @Schema(example = "Коллекционер_123", description = "Имя пользователя")
    @get:JsonProperty("username") val username: String? = null,

    @Schema(example = "https://example.com/avatars/user123.jpg", description = "Ссылка на аватар пользователя")
    @get:JsonProperty("avatar_url") val avatarUrl: String? = null
)
