package ru.vsu.app.dto.responses.auth.login

import com.fasterxml.jackson.annotation.JsonProperty
import io.swagger.v3.oas.annotations.media.Schema
import jakarta.validation.constraints.NotNull
import ru.vsu.app.dto.UserDto

/**
 *
 * @param user
 * @param accessToken
 */
data class LoginUser200Response(
    @field:NotNull
    @Schema(description = "Данные пользователя", required = true)
    @get:JsonProperty("user")
    val user: UserDto,

    @field:NotNull
    @Schema(description = "JWT токен для доступа", example = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...")
    @get:JsonProperty("accessToken")
    val accessToken: String
)
