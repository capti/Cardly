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
 * @param paymentID Уникальный идентификатор платежа
 * @param user 
 * @param paymentSUM Сумма платежа
 * @param paymentStatus Статус платежа
 * @param paymentDateTime Дата и время платежа
 * @param bankCardData Данные карты (только для записи)
 */
data class PaymentDto(

    @Schema(example = "601", required = true, description = "Уникальный идентификатор платежа")
    @get:JsonProperty("payment_ID", required = true) val paymentID: kotlin.Int,

    @field:Valid
    @Schema(required = true, description = "")
    @get:JsonProperty("user", required = true) val user: UserDto,

    @Schema(example = "199.99", required = true, description = "Сумма платежа")
    @get:JsonProperty("paymentSUM", required = true) val paymentSUM: kotlin.Double,

    @Schema(example = "Оплачено", required = true, description = "Статус платежа")
    @get:JsonProperty("paymentStatus", required = true) val paymentStatus: PaymentDto.PaymentStatus,

    @Schema(example = "2024-05-20T17:30Z", required = true, description = "Дата и время платежа")
    @get:JsonProperty("paymentDateTime", required = true) val paymentDateTime: java.time.LocalDateTime,

    @Schema(description = "Данные карты (только для записи)")
    @get:JsonProperty("bankCardData") val bankCardData: kotlin.collections.List<kotlin.String>? = null
    ) {

    /**
    * Статус платежа
    * Values: В_обработке,Оплачено,Ошибка
    */
    enum class PaymentStatus(@get:JsonValue val value: kotlin.String) {

        В_обработке("В обработке"),
        Оплачено("Оплачено"),
        Ошибка("Ошибка");

        companion object {
            @JvmStatic
            @JsonCreator
            fun forValue(value: kotlin.String): PaymentStatus {
                return values().first{it -> it.value == value}
            }
        }
    }

}

