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
 * @param status 
 * @param action 
 * @param banDurationDays Длительность бана в днях (только для temporary_ban)
 * @param comment 
 */
data class AdminReportsReportIDPutRequest(

    @Schema(example = "resolved", required = true, description = "")
    @get:JsonProperty("status", required = true) val status: AdminReportsReportIDPutRequest.Status,

    @Schema(example = "temporary_ban", required = true, description = "")
    @get:JsonProperty("action", required = true) val action: AdminReportsReportIDPutRequest.Action,

    @Schema(example = "7", description = "Длительность бана в днях (только для temporary_ban)")
    @get:JsonProperty("banDurationDays") val banDurationDays: kotlin.Int? = null,

    @Schema(example = "Пользователь получил временный бан на 7 дней за нарушение правил", description = "")
    @get:JsonProperty("comment") val comment: kotlin.String? = null
    ) {

    /**
    * 
    * Values: pending,reviewed,resolved
    */
    enum class Status(@get:JsonValue val value: kotlin.String) {

        pending("pending"),
        reviewed("reviewed"),
        resolved("resolved");

        companion object {
            @JvmStatic
            @JsonCreator
            fun forValue(value: kotlin.String): Status {
                return values().first{it -> it.value == value}
            }
        }
    }

    /**
    * 
    * Values: none,warning,temporary_ban,permanent_ban
    */
    enum class Action(@get:JsonValue val value: kotlin.String) {

        none("none"),
        warning("warning"),
        temporary_ban("temporary_ban"),
        permanent_ban("permanent_ban");

        companion object {
            @JvmStatic
            @JsonCreator
            fun forValue(value: kotlin.String): Action {
                return values().first{it -> it.value == value}
            }
        }
    }

}

