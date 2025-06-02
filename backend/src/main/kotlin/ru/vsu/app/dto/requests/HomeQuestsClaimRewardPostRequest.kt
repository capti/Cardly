package ru.vsu.app.dto.requests

import java.util.Objects
import com.fasterxml.jackson.annotation.JsonCreator
import com.fasterxml.jackson.annotation.JsonProperty
import com.fasterxml.jackson.annotation.JsonValue
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
 * @param questType 
 */
data class HomeQuestsClaimRewardPostRequest(

    @Schema(example = "daily", required = true, description = "")
    @get:JsonProperty("questType", required = true) val questType: HomeQuestsClaimRewardPostRequest.QuestType
    ) {

    /**
    * 
    * Values: daily,weekly
    */
    enum class QuestType(@get:JsonValue val value: kotlin.String) {

        daily("daily"),
        weekly("weekly");

        companion object {
            @JvmStatic
            @JsonCreator
            fun forValue(value: kotlin.String): QuestType {
                return values().first{it -> it.value == value}
            }
        }
    }

}

