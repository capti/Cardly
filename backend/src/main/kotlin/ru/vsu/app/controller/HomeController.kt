package ru.vsu.app.controller

import ru.vsu.app.dto.responses.home.HomeGenerateCardPost200Response
import ru.vsu.app.dto.responses.home.HomeGenerateCardPost402Response
import ru.vsu.app.dto.requests.HomeGenerateCardPostRequest
import ru.vsu.app.dto.responses.home.HomeNewsGet404Response
import ru.vsu.app.dto.responses.home.HomeNotificationsNotificationIDNavigatePost200Response
import ru.vsu.app.dto.responses.home.HomeNotificationsNotificationIDNavigatePost404Response
import ru.vsu.app.dto.responses.home.HomeQuestsClaimRewardPost200Response
import ru.vsu.app.dto.responses.home.HomeQuestsClaimRewardPost400Response
import ru.vsu.app.dto.requests.HomeQuestsClaimRewardPostRequest
import ru.vsu.app.dto.responses.home.HomeQuestsGet200Response
import ru.vsu.app.dto.responses.home.HomeQuestsQuestIDChangeStatusPost200Response
import ru.vsu.app.dto.responses.home.HomeSearchGet400Response
import ru.vsu.app.dto.responses.home.HomeSearchGet404Response
import ru.vsu.app.dto.NewsDto
import ru.vsu.app.dto.NotificationDto
import ru.vsu.app.dto.responses.common.InternalServerError
import ru.vsu.app.dto.ThemeDto
import ru.vsu.app.dto.UserDto
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
@Tag(name = "Home", description = "Операции на странице \"Главное меню\"")
class HomeController() {
    @Operation(
        summary = "Генерация уникальной карты",
        operationId = "homeGenerateCardPost",
        description = """Генерирует уникальную карту по выбранной теме, если на балансе достаточно средств
""",
        responses = [
            ApiResponse(responseCode = "200", description = "Карта успешно сгенерирована", content = [Content(schema = Schema(implementation = HomeGenerateCardPost200Response::class))]),
            ApiResponse(responseCode = "402", description = "Недостаточно средств", content = [Content(schema = Schema(implementation = HomeGenerateCardPost402Response::class))]),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.POST],
        value = ["/home/generate-card"],
        produces = ["application/json"],
        consumes = ["application/json"]
    )
    fun homeGenerateCardPost(@Parameter(description = "", required = true) @Valid @RequestBody homeGenerateCardPostRequest: HomeGenerateCardPostRequest): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Получение списка тем для генерации карт",
        operationId = "homeGenerateCardThemesGet",
        description = """Возвращает список доступных тем для генерации уникальных карт
""",
        responses = [
            ApiResponse(responseCode = "200", description = "Список тем", content = [Content(array = ArraySchema(schema = Schema(implementation = ThemeDto::class)))]),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.GET],
        value = ["/home/generate-card/themes"],
        produces = ["application/json"]
    )
    fun homeGenerateCardThemesGet(): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Получение списока новостей",
        operationId = "homeNewsGet",
        description = """Возвращает список новостей
""",
        responses = [
            ApiResponse(responseCode = "200", description = "Список новостей", content = [Content(array = ArraySchema(schema = Schema(implementation = NewsDto::class)))]),
            ApiResponse(responseCode = "404", description = "Новостей не найдено", content = [Content(schema = Schema(implementation = HomeNewsGet404Response::class))]),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ]
    )
    @RequestMapping(
        method = [RequestMethod.GET],
        value = ["/home/news"],
        produces = ["application/json"]
    )
    fun homeNewsGet(): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Просмотр новости",
        operationId = "homeNewsNewsIDGet",
        description = """Возвращает полную информацию по конкретной новости
""",
        responses = [
            ApiResponse(responseCode = "200", description = "Детальная информация о новости", content = [Content(schema = Schema(implementation = NewsDto::class))]),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ]
    )
    @RequestMapping(
        method = [RequestMethod.GET],
        value = ["/home/news/{news_ID}"],
        produces = ["application/json"]
    )
    fun homeNewsNewsIDGet(@Parameter(description = "", required = true) @PathVariable("news_ID") newsID: kotlin.Int): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Просмотр уведомлений",
        operationId = "homeNotificationsGet",
        description = """Возвращает список уведомлений пользователя
""",
        responses = [
            ApiResponse(responseCode = "200", description = "Список уведомлений", content = [Content(array = ArraySchema(schema = Schema(implementation = NotificationDto::class)))]),
            ApiResponse(responseCode = "401", description = "Ошибка аутентификации"),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.GET],
        value = ["/home/notifications"],
        produces = ["application/json"]
    )
    fun homeNotificationsGet(): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Просмотр уведомления",
        operationId = "homeNotificationsNotificationIDGet",
        description = """Возвращает информацию по конкретному уведомлению
""",
        responses = [
            ApiResponse(responseCode = "200", description = "Детальная информация об уведомлении", content = [Content(schema = Schema(implementation = NotificationDto::class))]),
            ApiResponse(responseCode = "401", description = "Ошибка аутентификации"),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.GET],
        value = ["/home/notifications/{notification_ID}"],
        produces = ["application/json"]
    )
    fun homeNotificationsNotificationIDGet(@Parameter(description = "", required = true) @PathVariable("notification_ID") notificationID: kotlin.Int): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Переход по ссылке в  уведомлении",
        operationId = "homeNotificationsNotificationIDNavigatePost",
        description = """Перенаправляет на страницу обмена, связанного с уведомлением
""",
        responses = [
            ApiResponse(responseCode = "200", description = "Перенаправление на страницу обмена", content = [Content(schema = Schema(implementation = HomeNotificationsNotificationIDNavigatePost200Response::class))]),
            ApiResponse(responseCode = "404", description = "Предложение обмена не найдено", content = [Content(schema = Schema(implementation = HomeNotificationsNotificationIDNavigatePost404Response::class))]),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.POST],
        value = ["/home/notifications/{notification_ID}/navigate"],
        produces = ["application/json"]
    )
    fun homeNotificationsNotificationIDNavigatePost(@Parameter(description = "", required = true) @PathVariable("notification_ID") notificationID: kotlin.Int): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Получение награды за выполнение квестов",
        operationId = "homeQuestsClaimRewardPost",
        description = """Выдает награду за выполнение квестов
""",
        responses = [
            ApiResponse(responseCode = "200", description = "Награда получена", content = [Content(schema = Schema(implementation = HomeQuestsClaimRewardPost200Response::class))]),
            ApiResponse(responseCode = "400", description = "Не все квесты выполнены", content = [Content(schema = Schema(implementation = HomeQuestsClaimRewardPost400Response::class))]),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.POST],
        value = ["/home/quests/claim-reward"],
        produces = ["application/json"],
        consumes = ["application/json"]
    )
    fun homeQuestsClaimRewardPost(@Parameter(description = "", required = true) @Valid @RequestBody homeQuestsClaimRewardPostRequest: HomeQuestsClaimRewardPostRequest): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Получение списка квестов",
        operationId = "homeQuestsGet",
        description = """Возвращает список ежедневных и еженедельных квестов с их статусом
""",
        responses = [
            ApiResponse(responseCode = "200", description = "Список квестов", content = [Content(schema = Schema(implementation = HomeQuestsGet200Response::class))]),
            ApiResponse(responseCode = "401", description = "Ошибка аутентификации"),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.GET],
        value = ["/home/quests"],
        produces = ["application/json"]
    )
    fun homeQuestsGet(): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Изменение статуса выполнения квеста",
        operationId = "homeQuestsQuestIDChangeStatusPost",
        description = """Изменение статуса выполнения квеста
""",
        responses = [
            ApiResponse(responseCode = "200", description = "Статус квеста успешно изменен", content = [Content(schema = Schema(implementation = HomeQuestsQuestIDChangeStatusPost200Response::class))]),
            ApiResponse(responseCode = "401", description = "Ошибка аутентификации"),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.POST],
        value = ["/home/quests/{quest_ID}/change-status"],
        produces = ["application/json"]
    )
    fun homeQuestsQuestIDChangeStatusPost(@Parameter(description = "", required = true) @PathVariable("quest_ID") questID: kotlin.Int): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Поиск пользователей",
        operationId = "homeSearchGet",
        description = """Поиск пользователей по никнейму или ID
""",
        responses = [
            ApiResponse(responseCode = "200", description = "Список найденных пользователей", content = [Content(array = ArraySchema(schema = Schema(implementation = UserDto::class)))]),
            ApiResponse(responseCode = "400", description = "Неверный запрос", content = [Content(schema = Schema(implementation = HomeSearchGet400Response::class))]),
            ApiResponse(responseCode = "404", description = "Пользователь не найден", content = [Content(schema = Schema(implementation = HomeSearchGet404Response::class))]),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ]
    )
    @RequestMapping(
        method = [RequestMethod.GET],
        value = ["/home/search"],
        produces = ["application/json"]
    )
    fun homeSearchGet( @RequestParam(value = "query", required = false) query: kotlin.String?): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }
}
