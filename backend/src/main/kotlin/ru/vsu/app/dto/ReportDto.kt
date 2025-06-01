package ru.vsu.app.dto

import java.util.Objects
import com.fasterxml.jackson.annotation.JsonCreator
import com.fasterxml.jackson.annotation.JsonProperty
import com.fasterxml.jackson.annotation.JsonValue
import ru.vsu.app.dto.UserDto
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
 * @param reportID Уникальный идентификатор жалобы
 * @param reporter 
 * @param reportedUser 
 * @param reportDateTime Дата и время жалобы
 * @param reason непристойный никнейм
 * @param status Статус рассмотрения
 */
data class ReportDto(

    @Schema(example = "301", required = true, description = "Уникальный идентификатор жалобы")
    @get:JsonProperty("report_ID", required = true) val reportID: kotlin.Int,

    @field:Valid
    @Schema(required = true, description = "")
    @get:JsonProperty("reporter", required = true) val reporter: UserDto,

    @field:Valid
    @Schema(required = true, description = "")
    @get:JsonProperty("reportedUser", required = true) val reportedUser: UserDto,

    @Schema(example = "2024-05-20T16:45Z", required = true, description = "Дата и время жалобы")
    @get:JsonProperty("reportDateTime", required = true) val reportDateTime: java.time.LocalDateTime,

    @Schema(example = "Непристойный контент", required = true, description = "непристойный никнейм")
    @get:JsonProperty("reason", required = true) val reason: kotlin.String,

    @Schema(example = "На расмотрении", required = true, description = "Статус рассмотрения")
    @get:JsonProperty("status", required = true) val status: ReportDto.Status
    ) {

    /**
    * Статус рассмотрения
    * Values: На_рассмотрении,Подтверждено,Отклонено
    */
    enum class Status(@get:JsonValue val value: kotlin.String) {

        На_рассмотрении("На рассмотрении"),
        Подтверждено("Подтверждено"),
        Отклонено("Отклонено");

        companion object {
            @JvmStatic
            @JsonCreator
            fun forValue(value: kotlin.String): Status {
                return values().first{it -> it.value == value}
            }
        }
    }

}

