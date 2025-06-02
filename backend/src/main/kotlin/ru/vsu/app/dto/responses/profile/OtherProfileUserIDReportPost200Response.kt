package ru.vsu.app.dto.responses.profile

import java.util.Objects
import com.fasterxml.jackson.annotation.JsonProperty
import ru.vsu.app.model.ReportEntity
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
 * @param redirectUrl 
 * @param reportDraft 
 */
data class OtherProfileUserIDReportPost200Response(

    @Schema(example = "/report/create?reported_user=123", description = "")
    @get:JsonProperty("redirectUrl") val redirectUrl: kotlin.String? = null,

    @field:Valid
    @Schema(description = "")
    @get:JsonProperty("reportDraft") val reportDraft: ReportEntity? = null
    ) {

}

