package ru.vsu.app.controller

import ru.vsu.app.dto.responses.profile.OtherProfileCardCardIDInitiateTradePost400Response
import ru.vsu.app.dto.responses.profile.OtherProfileCardCardIDInitiateTradePost409Response
import ru.vsu.app.dto.responses.profile.OtherProfileCardCardIDInitiateTradePost200Response
import ru.vsu.app.dto.responses.profile.OtherProfileCardCardIDViewGet200Response
import ru.vsu.app.dto.responses.profile.OtherProfileUserIDGet200Response
import ru.vsu.app.dto.responses.profile.OtherProfileUserIDInventoryGet200Response
import ru.vsu.app.dto.responses.profile.OtherProfileUserIDInventoryGet403Response
import ru.vsu.app.dto.responses.profile.OtherProfileUserIDReportPost200Response
import ru.vsu.app.dto.requests.OtherProfileUserIDReportPostRequest
import ru.vsu.app.dto.responses.profile.ProfileAchievementsGet200Response
import ru.vsu.app.dto.responses.common.InternalServerError
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

@RestController
@Validated
@RequestMapping("\${api.base-path:/api}")
@SecurityRequirement(name = "Bearer Authentication")
@Tag(name = "OtherProfile", description = "Операции при просмотре профиля другого пользователя")
class OtherProfileController() {

    @Operation(
        summary = "Предложение обмена",
        operationId = "otherProfileCardCardIDInitiateTradePost",
        description = """Создает предложение обмена для указанной карты
и перенаправляет на страницу создания обмена
""",
        responses = [
            ApiResponse(responseCode = "200", description = "Перенаправление на создание обмена", content = [Content(schema = Schema(implementation = OtherProfileCardCardIDInitiateTradePost200Response::class))]),
            ApiResponse(responseCode = "400", description = "Невозможно предложить обмен", content = [Content(schema = Schema(implementation = OtherProfileCardCardIDInitiateTradePost400Response::class))]),
            ApiResponse(responseCode = "409", description = "Конфликт при попытке обмена", content = [Content(schema = Schema(implementation = OtherProfileCardCardIDInitiateTradePost409Response::class))]),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.POST],
        value = ["/other-profile/card/{card_ID}/initiate-trade"],
        produces = ["application/json"]
    )
    fun otherProfileCardCardIDInitiateTradePost(@Parameter(description = "", required = true) @PathVariable("card_ID") cardID: kotlin.Int, @RequestParam(value = "owner_ID", required = true) ownerID: kotlin.Int): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Просмотр карты другого пользователя",
        operationId = "otherProfileCardCardIDViewGet",
        description = """Возвращает детальную информацию о карте другого пользователя
и возвращает кнопку для создания предложения обмена
""",
        responses = [
            ApiResponse(responseCode = "200", description = "Информация о карте", content = [Content(schema = Schema(implementation = OtherProfileCardCardIDViewGet200Response::class))]),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ]
    )
    @RequestMapping(
        method = [RequestMethod.GET],
        value = ["/other-profile/card/{card_ID}/view"],
        produces = ["application/json"]
    )
    fun otherProfileCardCardIDViewGet(@Parameter(description = "", required = true) @PathVariable("card_ID") cardID: kotlin.Int, @RequestParam(value = "owner_ID", required = true) ownerID: kotlin.Int): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Получение списка достижений другого пользователя",
        operationId = "otherProfileUserIDAchievementsGet",
        description = """Возвращает полный список достижений с текущим статусом выполнения
""",
        responses = [
            ApiResponse(responseCode = "200", description = "Список достижений", content = [Content(schema = Schema(implementation = ProfileAchievementsGet200Response::class))]),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ]
    )
    @RequestMapping(
        method = [RequestMethod.GET],
        value = ["/other-profile/{user_id}/achievements"],
        produces = ["application/json"]
    )
    fun otherProfileUserIDAchievementsGet(@Parameter(description = "", required = true) @PathVariable("user_id") userID: kotlin.Int): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Получение данных профиля другого пользователя",
        operationId = "otherProfileUserIDGet",
        description = """Загружает данные профиля другого пользователя.
- Возвращает статистику, избранные карты и достижения
- Проверяет настройки приватности инвентаря
""",
        responses = [
            ApiResponse(responseCode = "200", description = "Данные профиля", content = [Content(schema = Schema(implementation = OtherProfileUserIDGet200Response::class))]),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ]
    )
    @RequestMapping(
        method = [RequestMethod.GET],
        value = ["/other-profile/{user_id}"],
        produces = ["application/json"]
    )
    fun otherProfileUserIDGet(@Parameter(description = "", required = true) @PathVariable("user_id") userID: kotlin.Int): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Просмотр инвентаря другого пользователя",
        operationId = "otherProfileUserIDInventoryGet",
        description = """Возвращает инвентарь пользователя, если он не скрыт в настройках
""",
        responses = [
            ApiResponse(responseCode = "200", description = "Инвентарь пользователя", content = [Content(schema = Schema(implementation = OtherProfileUserIDInventoryGet200Response::class))]),
            ApiResponse(responseCode = "403", description = "Инвентарь скрыт", content = [Content(schema = Schema(implementation = OtherProfileUserIDInventoryGet403Response::class))]),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ]
    )
    @RequestMapping(
        method = [RequestMethod.GET],
        value = ["/other-profile/{user_id}/inventory"],
        produces = ["application/json"]
    )
    fun otherProfileUserIDInventoryGet(@Parameter(description = "", required = true) @PathVariable("user_id") userID: kotlin.Int): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Подача жалобы на пользователя",
        operationId = "otherProfileUserIDReportPost",
        description = """Перенаправляет на страницу создания жалобы.
""",
        responses = [
            ApiResponse(responseCode = "200", description = "Перенаправление на страницу создания жалобы", content = [Content(schema = Schema(implementation = OtherProfileUserIDReportPost200Response::class))]),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.POST],
        value = ["/other-profile/{user_id}/report"],
        produces = ["application/json"],
        consumes = ["application/json"]
    )
    fun otherProfileUserIDReportPost(@Parameter(description = "", required = true) @PathVariable("user_id") userID: kotlin.Int,@Parameter(description = "", required = true) @Valid @RequestBody otherProfileUserIDReportPostRequest: OtherProfileUserIDReportPostRequest): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }
}
