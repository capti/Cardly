package ru.vsu.app.dto.responses.admin

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
 * @param totalUsers 
 * @param activeUsers 
 * @param bannedUsers 
 * @param totalCards 
 * @param totalTrades 
 * @param completedTrades 
 * @param invalidatedTrades 
 * @param pendingReports 
 */
data class AdminStatsGet200Response(

    @Schema(example = "1000", description = "")
    @get:JsonProperty("totalUsers") val totalUsers: kotlin.Int? = null,

    @Schema(example = "750", description = "")
    @get:JsonProperty("activeUsers") val activeUsers: kotlin.Int? = null,

    @Schema(example = "25", description = "")
    @get:JsonProperty("bannedUsers") val bannedUsers: kotlin.Int? = null,

    @Schema(example = "5000", description = "")
    @get:JsonProperty("totalCards") val totalCards: kotlin.Int? = null,

    @Schema(example = "1200", description = "")
    @get:JsonProperty("totalTrades") val totalTrades: kotlin.Int? = null,

    @Schema(example = "1000", description = "")
    @get:JsonProperty("completedTrades") val completedTrades: kotlin.Int? = null,

    @Schema(example = "50", description = "")
    @get:JsonProperty("invalidatedTrades") val invalidatedTrades: kotlin.Int? = null,

    @Schema(example = "15", description = "")
    @get:JsonProperty("pendingReports") val pendingReports: kotlin.Int? = null
    ) {

}

