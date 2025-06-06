package ru.vsu.app.dto

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
 * @param totalCards 
 * @param completedCollections 
 */
data class UserStatsDto(

    @Schema(example = "150", description = "")
    @get:JsonProperty("totalCards") val totalCards: kotlin.Int? = null,

    @Schema(example = "5", description = "")
    @get:JsonProperty("completedCollections") val completedCollections: kotlin.Int? = null
    ) {

}

