package ru.vsu.app.dto.responses.shop

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
 * @param success 
 * @param transactionId 
 */
data class ShopPaymentsProcessPost200Response(

    @Schema(description = "")
    @get:JsonProperty("success") val success: kotlin.Boolean? = null,

    @Schema(description = "")
    @get:JsonProperty("transactionId") val transactionId: kotlin.String? = null
    ) {

}

