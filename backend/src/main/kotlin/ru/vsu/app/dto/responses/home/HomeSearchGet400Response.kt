package ru.vsu.app.dto.responses.home

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
 */
data class HomeSearchGet400Response(

    @Schema(example = "Введите минимум 3 символа для поиска", description = "")
    @get:JsonProperty("error") val error: kotlin.String? = null
    ) {

}

