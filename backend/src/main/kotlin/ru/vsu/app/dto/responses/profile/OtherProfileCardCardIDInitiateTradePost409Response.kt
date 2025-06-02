package ru.vsu.app.dto.responses.profile

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
 * @param error 
 * @param cardQuantity Количество экземпляров карты у владельца
 */
data class OtherProfileCardCardIDInitiateTradePost409Response(

    @Schema(example = "Невозможно предложить обмен - у владельца только один экземпляр этой карты", description = "")
    @get:JsonProperty("error") val error: kotlin.String? = null,

    @Schema(example = "1", description = "Количество экземпляров карты у владельца")
    @get:JsonProperty("cardQuantity") val cardQuantity: kotlin.Int? = null
    ) {

}

