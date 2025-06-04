package ru.vsu.app.dto.responses.profile

import java.util.Objects
import com.fasterxml.jackson.annotation.JsonProperty
import ru.vsu.app.dto.AchievementDto
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
 * @param achievements 
 */
data class ProfileAchievementsGet200Response(

    @field:Valid
    @Schema(description = "")
    @get:JsonProperty("achievements") val achievements: kotlin.collections.List<AchievementDto>? = null
    ) {

}

