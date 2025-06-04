package ru.vsu.app.dto.responses.home

import java.util.Objects
import com.fasterxml.jackson.annotation.JsonProperty
import ru.vsu.app.model.PackEntity
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
 * @param receivedCoins 
 * @param receivedPacks 
 * @param newBalance 
 */
data class HomeQuestsClaimRewardPost200Response(

    @Schema(example = "500", description = "")
    @get:JsonProperty("receivedCoins") val receivedCoins: kotlin.Int? = null,

    @field:Valid
    @Schema(description = "")
    @get:JsonProperty("receivedPacks") val receivedPacks: kotlin.collections.List<PackEntity>? = null,

    @Schema(example = "2000", description = "")
    @get:JsonProperty("newBalance") val newBalance: kotlin.Int? = null
    ) {

}

