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
 * @param reason Причина жалобы
 * @param comment Дополнительные комментарии
 */
data class OtherProfileUserIDReportPostRequest(

    @Schema(example = "Неуместный никнейм", required = true, description = "Причина жалобы")
    @get:JsonProperty("reason", required = true) val reason: OtherProfileUserIDReportPostRequest.Reason,

    @get:Size(max=500)
    @Schema(example = "Никнейм содержит нецензурные слова", description = "Дополнительные комментарии")
    @get:JsonProperty("comment") val comment: kotlin.String? = null
    ) {

    /**
    * Причина жалобы
    * Values: Неуместный_никнейм,Неуместный_аватар,Другое
    */
    enum class Reason(@get:JsonValue val value: kotlin.String) {

        Неуместный_никнейм("Неуместный никнейм"),
        Неуместный_аватар("Неуместный аватар"),
        Другое("Другое");

        companion object {
            @JvmStatic
            @JsonCreator
            fun forValue(value: kotlin.String): Reason {
                return values().first{it -> it.value == value}
            }
        }
    }

}

