package ru.vsu.app.dto.responses.profile

import java.util.Objects
import com.fasterxml.jackson.annotation.JsonProperty
import ru.vsu.app.model.AchievementEntity
import ru.vsu.app.model.CardEntity
import ru.vsu.app.model.UserStatsEntity
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
 * @param userStats 
 * @param favoriteCards 
 * @param favoriteAchievements 
 * @param inventoryVisible 
 * @param id 
 * @param username 
 */
data class OtherProfileUserIDGet200Response(

    @field:Valid
    @Schema(description = "")
    @get:JsonProperty("userStats") val userStats: UserStatsEntity? = null,

    @field:Valid
    @get:Size(max=5)
    @Schema(description = "")
    @get:JsonProperty("favoriteCards") val favoriteCards: kotlin.collections.List<CardEntity>? = null,

    @field:Valid
    @get:Size(max=4)
    @Schema(description = "")
    @get:JsonProperty("favoriteAchievements") val favoriteAchievements: kotlin.collections.List<AchievementEntity>? = null,

    @Schema(example = "true", description = "")
    @get:JsonProperty("inventoryVisible") val inventoryVisible: kotlin.Boolean? = null,

    @Schema(example = "456", description = "")
    @get:JsonProperty("id") val id: kotlin.Int? = null,

    @Schema(example = "Игрок_456", description = "")
    @get:JsonProperty("username") val username: kotlin.String? = null
    ) {

}

