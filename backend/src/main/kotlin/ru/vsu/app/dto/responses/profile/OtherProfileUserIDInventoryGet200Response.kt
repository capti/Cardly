package ru.vsu.app.dto.responses.profile

import java.util.Objects
import com.fasterxml.jackson.annotation.JsonProperty
import ru.vsu.app.model.CardEntity
import ru.vsu.app.model.CollectionEntity
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
 * @param cards 
 * @param collections 
 */
data class OtherProfileUserIDInventoryGet200Response(

    @field:Valid
    @Schema(description = "")
    @get:JsonProperty("cards") val cards: kotlin.collections.List<CardEntity>? = null,

    @field:Valid
    @Schema(description = "")
    @get:JsonProperty("collections") val collections: kotlin.collections.List<CollectionEntity>? = null
    ) {

}

