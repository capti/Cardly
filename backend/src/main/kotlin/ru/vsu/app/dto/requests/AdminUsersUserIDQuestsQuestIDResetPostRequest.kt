package ru.vsu.app.dto.requests

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
 * @param reason Причина сброса квеста
 * @param removeRewards Нужно ли удалить награды за квест
 */
data class AdminUsersUserIDQuestsQuestIDResetPostRequest(

    @Schema(required = true, description = "Причина сброса квеста")
    @get:JsonProperty("reason", required = true) val reason: kotlin.String,

    @Schema(description = "Нужно ли удалить награды за квест")
    @get:JsonProperty("removeRewards") val removeRewards: kotlin.Boolean? = false
    ) {

}

