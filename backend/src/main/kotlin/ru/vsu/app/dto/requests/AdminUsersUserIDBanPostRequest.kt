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
 * @param banType 
 * @param reason 
 * @param durationDays Длительность бана в днях
 */
data class AdminUsersUserIDBanPostRequest(

    @Schema(example = "temporary", required = true, description = "")
    @get:JsonProperty("banType", required = true) val banType: AdminUsersUserIDBanPostRequest.BanType,

    @Schema(example = "Нарушение правил сообщества", required = true, description = "")
    @get:JsonProperty("reason", required = true) val reason: kotlin.String,

    @Schema(example = "7", description = "Длительность бана в днях")
    @get:JsonProperty("durationDays") val durationDays: kotlin.Int? = null
    ) {

    /**
    * 
    * Values: temporary,permanent
    */
    enum class BanType(@get:JsonValue val value: kotlin.String) {

        temporary("temporary"),
        permanent("permanent");

        companion object {
            @JvmStatic
            @JsonCreator
            fun forValue(value: kotlin.String): BanType {
                return values().first{it -> it.value == value}
            }
        }
    }

}

