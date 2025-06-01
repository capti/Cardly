package ru.vsu.app.controller

import ru.vsu.app.dto.responses.profile.ProfileAchievementsFavoritesCountGet200Response
import ru.vsu.app.dto.responses.profile.ProfileAchievementsGet200Response
import ru.vsu.app.dto.responses.profile.ProfileGet200Response
import ru.vsu.app.dto.responses.common.InternalServerError
import ru.vsu.app.dto.UserSettingsDto
import io.swagger.v3.oas.annotations.*
import io.swagger.v3.oas.annotations.enums.*
import io.swagger.v3.oas.annotations.media.*
import io.swagger.v3.oas.annotations.responses.*
import io.swagger.v3.oas.annotations.security.*
import io.swagger.v3.oas.annotations.tags.Tag
import org.springframework.http.HttpStatus
import org.springframework.http.MediaType
import org.springframework.http.ResponseEntity

import org.springframework.web.bind.annotation.*
import org.springframework.validation.annotation.Validated
import org.springframework.web.context.request.NativeWebRequest
import org.springframework.beans.factory.annotation.Autowired

import jakarta.validation.Valid
import jakarta.validation.constraints.DecimalMax
import jakarta.validation.constraints.DecimalMin
import jakarta.validation.constraints.Email
import jakarta.validation.constraints.Max
import jakarta.validation.constraints.Min
import jakarta.validation.constraints.NotNull
import jakarta.validation.constraints.Pattern
import jakarta.validation.constraints.Size

import kotlin.collections.List
import kotlin.collections.Map

@SecurityRequirement(name = "Bearer Authentication")
@RestController
@Validated
@RequestMapping("\${api.base-path:/api}")
@Tag(name = "Profile", description = "Операции в профиле пользователя")
class ProfileController() {

    @Operation(
        summary = "Добавить достижение в избранное",
        operationId = "profileAchievementsAchievementIDFavoriteAddPost",
        description = """Добавляет достижение в избранное (максимум 4)
""",
        responses = [
            ApiResponse(responseCode = "200", description = "Успешно добавлено в избранное"),
            ApiResponse(responseCode = "400", description = "Невозможно добавить в избранное (лимит достигнут)"),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.POST],
        value = ["/profile/achievements/{achievement_ID}/favorite-add"],
        produces = ["application/json"]
    )
    fun profileAchievementsAchievementIDFavoriteAddPost(@Parameter(description = "", required = true) @PathVariable("achievement_ID") achievementID: kotlin.Int): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Удалить достижение из избранного",
        operationId = "profileAchievementsAchievementIDFavoriteDeleteDelete",
        description = """Удаляет достижение из избранного
""",
        responses = [
            ApiResponse(responseCode = "200", description = "Успешно удалено из избранного"),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.DELETE],
        value = ["/profile/achievements/{achievement_ID}/favorite-delete"],
        produces = ["application/json"]
    )
    fun profileAchievementsAchievementIDFavoriteDeleteDelete(@Parameter(description = "", required = true) @PathVariable("achievement_ID") achievementID: kotlin.Int): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Проверка количества избранных достижений",
        operationId = "profileAchievementsFavoritesCountGet",
        description = """Возвращает текущее количество избранных достижений
""",
        responses = [
            ApiResponse(responseCode = "200", description = "Количество избранных", content = [Content(schema = Schema(implementation = ProfileAchievementsFavoritesCountGet200Response::class))]),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.GET],
        value = ["/profile/achievements/favorites/count"],
        produces = ["application/json"]
    )
    fun profileAchievementsFavoritesCountGet(): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Получение списка достижений",
        operationId = "profileAchievementsGet",
        description = """Возвращает полный список достижений с текущим статусом выполнения
""",
        responses = [
            ApiResponse(responseCode = "200", description = "Список достижений", content = [Content(schema = Schema(implementation = ProfileAchievementsGet200Response::class))]),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.GET],
        value = ["/profile/achievements"],
        produces = ["application/json"]
    )
    fun profileAchievementsGet(): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Получение данных профиля",
        operationId = "profileGet",
        description = """Загружает данные профиля пользователя.
- Проверяет авторизацию
- Возвращает статистику, избранные карты и достижения
""",
        responses = [
            ApiResponse(responseCode = "200", description = "Данные профиля", content = [Content(schema = Schema(implementation = ProfileGet200Response::class))]),
            ApiResponse(responseCode = "401", description = "Ошибка аутентификации"),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.GET],
        value = ["/profile"],
        produces = ["application/json"]
    )
    fun profileGet(): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Обновление настроек",
        operationId = "profileSettingsChangePut",
        description = """Обновляет настройки профиля
""",
        responses = [
            ApiResponse(responseCode = "200", description = "Настройки обновлены", content = [Content(schema = Schema(implementation = UserSettingsDto::class))]),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.PUT],
        value = ["/profile/settings-change"],
        produces = ["application/json"],
        consumes = ["application/json"]
    )
    fun profileSettingsChangePut(@Parameter(description = "", required = true) @Valid @RequestBody userSettings: UserSettingsDto): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Получение настроек",
        operationId = "profileSettingsGet",
        description = """Возвращает текущие настройки профиля
""",
        responses = [
            ApiResponse(responseCode = "200", description = "Настройки профиля", content = [Content(schema = Schema(implementation = UserSettingsDto::class))]),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.GET],
        value = ["/profile/settings"],
        produces = ["application/json"]
    )
    fun profileSettingsGet(): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }
}
