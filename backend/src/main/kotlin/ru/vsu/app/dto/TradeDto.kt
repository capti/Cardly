package ru.vsu.app.dto

import java.util.Objects
import com.fasterxml.jackson.annotation.JsonProperty
import ru.vsu.app.dto.CardDto
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
 * @param tradeID Уникальный идентификатор обмена
 * @param offeringUser 
 * @param offeringCards Предлагаемые карты
 * @param receivingUser 
 * @param receivingCards Запрашиваемые карты
 * @param isConfirmed Статус подтверждения
 * @param tradeDateTime Дата и время обмена
 */
data class TradeDto(

    @Schema(example = "701", required = true, description = "Уникальный идентификатор обмена")
    @get:JsonProperty("trade_ID", required = true) val tradeID: kotlin.Int,

    @field:Valid
    @Schema(required = true, description = "")
    @get:JsonProperty("offeringUser", required = true) val offeringUser: UserDto,

    @field:Valid
    @Schema(required = true, description = "Предлагаемые карты")
    @get:JsonProperty("offeringCards", required = true) val offeringCards: kotlin.collections.List<CardDto>,

    @field:Valid
    @Schema(required = true, description = "")
    @get:JsonProperty("receivingUser", required = true) val receivingUser: UserDto,

    @field:Valid
    @Schema(required = true, description = "Запрашиваемые карты")
    @get:JsonProperty("receivingCards", required = true) val receivingCards: kotlin.collections.List<CardDto>,

    @Schema(example = "false", required = true, description = "Статус подтверждения")
    @get:JsonProperty("isConfirmed", required = true) val isConfirmed: kotlin.Boolean,

    @Schema(example = "2024-05-20T18:00Z", required = true, description = "Дата и время обмена")
    @get:JsonProperty("tradeDateTime", required = true) val tradeDateTime: java.time.LocalDateTime
    ) {

}

