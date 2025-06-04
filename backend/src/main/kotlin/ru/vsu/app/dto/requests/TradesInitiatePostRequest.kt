package ru.vsu.app.dto.requests

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
 * @param offeredCardId ID карты, которую предлагает текущий пользователь
 * @param requestedCardId ID карт, на которые пользователь готов совершить \"быстрый обмен\"
 */
data class TradesInitiatePostRequest(

    @Schema(example = "401", required = true, description = "ID карты, которую предлагает текущий пользователь")
    @get:JsonProperty("offeredCardId", required = true) val offeredCardId: kotlin.Int,

    @Schema(example = "[100,200]", required = true, description = "ID карт, на которые пользователь готов совершить \"быстрый обмен\"")
    @get:JsonProperty("requestedCardId", required = true) val requestedCardId: kotlin.collections.List<kotlin.Int>
    ) {

}

