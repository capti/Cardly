package ru.vsu.app.dto

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
 * @param transactionId 
 * @param status 
 * @param amount 
 * @param currency 
 * @param offerId 
 */
data class PaymentCallbackDto(

    @Schema(required = true, description = "")
    @get:JsonProperty("transactionId", required = true) val transactionId: kotlin.String,

    @Schema(required = true, description = "")
    @get:JsonProperty("status", required = true) val status: PaymentCallbackDto.Status,

    @Schema(required = true, description = "")
    @get:JsonProperty("amount", required = true) val amount: java.math.BigDecimal,

    @Schema(description = "")
    @get:JsonProperty("currency") val currency: kotlin.String? = null,

    @Schema(description = "")
    @get:JsonProperty("offerId") val offerId: kotlin.Int? = null
    ) {

    /**
    * 
    * Values: Успешно,Ошибка,В_процессе
    */
    enum class Status(@get:JsonValue val value: kotlin.String) {

        Успешно("Успешно"),
        Ошибка("Ошибка"),
        В_процессе("В процессе");

        companion object {
            @JvmStatic
            @JsonCreator
            fun forValue(value: kotlin.String): Status {
                return values().first{it -> it.value == value}
            }
        }
    }

}

