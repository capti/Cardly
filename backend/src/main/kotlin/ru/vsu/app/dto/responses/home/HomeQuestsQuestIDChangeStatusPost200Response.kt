package ru.vsu.app.dto.responses.home

import java.util.Objects
import com.fasterxml.jackson.annotation.JsonProperty
import ru.vsu.app.model.QuestEntity
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
 * @param quest 
 * @param message 
 */
data class HomeQuestsQuestIDChangeStatusPost200Response(

    @field:Valid
    @Schema(description = "")
    @get:JsonProperty("quest") val quest: QuestEntity? = null,

    @Schema(example = "Статус квеста успешно изменен", description = "")
    @get:JsonProperty("message") val message: kotlin.String? = null
    ) {

}

