package ru.vsu.app.controller

import ru.vsu.app.dto.AchievementDto
import ru.vsu.app.dto.requests.AdminReportsReportIDPutRequest
import ru.vsu.app.dto.responses.admin.AdminStatsGet200Response
import ru.vsu.app.dto.responses.admin.AdminTradesTradeIDInvalidatePost200Response
import ru.vsu.app.dto.requests.AdminTradesTradeIDInvalidatePostRequest
import ru.vsu.app.dto.responses.admin.AdminUsersUserIDBanPost200Response
import ru.vsu.app.dto.requests.AdminUsersUserIDBanPostRequest
import ru.vsu.app.dto.responses.admin.AdminUsersUserIDQuestsQuestIDResetPost200Response
import ru.vsu.app.dto.requests.AdminUsersUserIDQuestsQuestIDResetPostRequest
import ru.vsu.app.dto.responses.admin.AdminUsersUserIDUnbanPost200Response
import ru.vsu.app.dto.CardDto
import ru.vsu.app.dto.CoinOfferDto
import ru.vsu.app.dto.CollectionDto
import ru.vsu.app.dto.NewsDto
import ru.vsu.app.dto.PackDto
import ru.vsu.app.dto.responses.common.InternalServerError
import ru.vsu.app.dto.ReportDto
import ru.vsu.app.dto.TradeDto
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
@Tag(name = "Admin", description = "Функции администратора")
class AdminController() {

    @Operation(
        summary = "Удаление достижения",
        operationId = "adminAchievementsAchievementIDDelete",
        description = """Удаляет достижение из системы""",
        responses = [
            ApiResponse(responseCode = "204", description = "Достижение успешно удалено"),
            ApiResponse(responseCode = "401", description = "Ошибка аутентификации"),
            ApiResponse(responseCode = "403", description = "Доступ запрещен"),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.DELETE],
        value = ["/admin/achievements/{achievement_ID}"],
        produces = ["application/json"]
    )
    fun adminAchievementsAchievementIDDelete(@Parameter(description = "", required = true) @PathVariable("achievement_ID") achievementID: kotlin.Int): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Обновление достижения",
        operationId = "adminAchievementsAchievementIDPut",
        description = """Обновляет информацию о достижении""",
        responses = [
            ApiResponse(responseCode = "200", description = "Достижение успешно обновлено", content = [Content(schema = Schema(implementation = AchievementDto::class))]),
            ApiResponse(responseCode = "401", description = "Ошибка аутентификации"),
            ApiResponse(responseCode = "403", description = "Доступ запрещен"),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.PUT],
        value = ["/admin/achievements/{achievement_ID}"],
        produces = ["application/json"],
        consumes = ["application/json"]
    )
    fun adminAchievementsAchievementIDPut(@Parameter(description = "", required = true) @PathVariable("achievement_ID") achievementID: kotlin.Int,@Parameter(description = "", required = true) @Valid @RequestBody achievement: AchievementDto): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Создание достижения",
        operationId = "adminAchievementsPost",
        description = """Создает новое достижение в системе""",
        responses = [
            ApiResponse(responseCode = "201", description = "Достижение успешно создано", content = [Content(schema = Schema(implementation = AchievementDto::class))]),
            ApiResponse(responseCode = "401", description = "Ошибка аутентификации"),
            ApiResponse(responseCode = "403", description = "Доступ запрещен"),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.POST],
        value = ["/admin/achievements"],
        produces = ["application/json"],
        consumes = ["application/json"]
    )
    fun adminAchievementsPost(@Parameter(description = "", required = true) @Valid @RequestBody achievement: AchievementDto): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Удаление карты",
        operationId = "adminCardsCardIDDelete",
        description = """Удаляет карту из системы""",
        responses = [
            ApiResponse(responseCode = "204", description = "Карта успешно удалена"),
            ApiResponse(responseCode = "401", description = "Ошибка аутентификации"),
            ApiResponse(responseCode = "403", description = "Доступ запрещен"),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.DELETE],
        value = ["/admin/cards/{card_ID}"],
        produces = ["application/json"]
    )
    fun adminCardsCardIDDelete(@Parameter(description = "", required = true) @PathVariable("card_ID") cardID: kotlin.Int): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Обновление карты",
        operationId = "adminCardsCardIDPut",
        description = """Обновляет информацию о карте""",
        responses = [
            ApiResponse(responseCode = "200", description = "Карта успешно обновлена", content = [Content(schema = Schema(implementation = CardDto::class))]),
            ApiResponse(responseCode = "401", description = "Ошибка аутентификации"),
            ApiResponse(responseCode = "403", description = "Доступ запрещен"),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.PUT],
        value = ["/admin/cards/{card_ID}"],
        produces = ["application/json"],
        consumes = ["application/json"]
    )
    fun adminCardsCardIDPut(@Parameter(description = "", required = true) @PathVariable("card_ID") cardID: kotlin.Int,@Parameter(description = "", required = true) @Valid @RequestBody card: CardDto): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Создание новой карты",
        operationId = "adminCardsPost",
        description = """Создает новую карту в системе""",
        responses = [
            ApiResponse(responseCode = "201", description = "Карта успешно создана", content = [Content(schema = Schema(implementation = CardDto::class))]),
            ApiResponse(responseCode = "401", description = "Ошибка аутентификации"),
            ApiResponse(responseCode = "403", description = "Доступ запрещен"),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.POST],
        value = ["/admin/cards"],
        produces = ["application/json"],
        consumes = ["application/json"]
    )
    fun adminCardsPost(@Parameter(description = "", required = true) @Valid @RequestBody card: CardDto): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Получение списка предложений покупки монет",
        operationId = "adminCoinOffersGet",
        description = """Возвращает список всех предложений покупки монет""",
        responses = [
            ApiResponse(responseCode = "200", description = "Список предложений успешно получен", content = [Content(array = ArraySchema(schema = Schema(implementation = CoinOfferDto::class)))]),
            ApiResponse(responseCode = "401", description = "Ошибка аутентификации"),
            ApiResponse(responseCode = "403", description = "Доступ запрещен"),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.GET],
        value = ["/admin/coin-offers"],
        produces = ["application/json"]
    )
    fun adminCoinOffersGet(): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Удаление предложения покупки монет",
        operationId = "adminCoinOffersOfferIdDelete",
        description = """Удаляет предложение покупки монет из системы""",
        responses = [
            ApiResponse(responseCode = "204", description = "Предложение успешно удалено"),
            ApiResponse(responseCode = "401", description = "Ошибка аутентификации"),
            ApiResponse(responseCode = "403", description = "Доступ запрещен"),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.DELETE],
        value = ["/admin/coin-offers/{offer_id}"],
        produces = ["application/json"]
    )
    fun adminCoinOffersOfferIdDelete(@Parameter(description = "", required = true) @PathVariable("offer_id") offerId: kotlin.Int): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Обновление предложения покупки монет",
        operationId = "adminCoinOffersOfferIdPut",
        description = """Обновляет информацию о предложении покупки монет""",
        responses = [
            ApiResponse(responseCode = "200", description = "Предложение успешно обновлено", content = [Content(schema = Schema(implementation = CoinOfferDto::class))]),
            ApiResponse(responseCode = "401", description = "Ошибка аутентификации"),
            ApiResponse(responseCode = "403", description = "Доступ запрещен"),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.PUT],
        value = ["/admin/coin-offers/{offer_id}"],
        produces = ["application/json"],
        consumes = ["application/json"]
    )
    fun adminCoinOffersOfferIdPut(@Parameter(description = "", required = true) @PathVariable("offer_id") offerId: kotlin.Int,@Parameter(description = "", required = true) @Valid @RequestBody coinOffer: CoinOfferDto): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Создание предложения покупки монет",
        operationId = "adminCoinOffersPost",
        description = """Создает новое предложение покупки монет в системе""",
        responses = [
            ApiResponse(responseCode = "201", description = "Предложение успешно создано", content = [Content(schema = Schema(implementation = CoinOfferDto::class))]),
            ApiResponse(responseCode = "401", description = "Ошибка аутентификации"),
            ApiResponse(responseCode = "403", description = "Доступ запрещен"),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.POST],
        value = ["/admin/coin-offers"],
        produces = ["application/json"],
        consumes = ["application/json"]
    )
    fun adminCoinOffersPost(@Parameter(description = "", required = true) @Valid @RequestBody coinOffer: CoinOfferDto): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Удаление коллекцию",
        operationId = "adminCollectionsCollectionIDDelete",
        description = """Удаляет коллекцию из системы""",
        responses = [
            ApiResponse(responseCode = "204", description = "Коллекция успешно удалена"),
            ApiResponse(responseCode = "401", description = "Ошибка аутентификации"),
            ApiResponse(responseCode = "403", description = "Доступ запрещен"),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.DELETE],
        value = ["/admin/collections/{collection_ID}"],
        produces = ["application/json"]
    )
    fun adminCollectionsCollectionIDDelete(@Parameter(description = "", required = true) @PathVariable("collection_ID") collectionID: kotlin.Int): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Обновление коллекции",
        operationId = "adminCollectionsCollectionIDPut",
        description = """Обновляет информацию о коллекции""",
        responses = [
            ApiResponse(responseCode = "200", description = "Коллекция успешно обновлена", content = [Content(schema = Schema(implementation = CollectionDto::class))]),
            ApiResponse(responseCode = "401", description = "Ошибка аутентификации"),
            ApiResponse(responseCode = "403", description = "Доступ запрещен"),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.PUT],
        value = ["/admin/collections/{collection_ID}"],
        produces = ["application/json"],
        consumes = ["application/json"]
    )
    fun adminCollectionsCollectionIDPut(@Parameter(description = "", required = true) @PathVariable("collection_ID") collectionID: kotlin.Int,@Parameter(description = "", required = true) @Valid @RequestBody collection: CollectionDto): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Создание новой коллекции",
        operationId = "adminCollectionsPost",
        description = """Создает новую коллекцию карт""",
        responses = [
            ApiResponse(responseCode = "201", description = "Коллекция успешно создана", content = [Content(schema = Schema(implementation = CollectionDto::class))]),
            ApiResponse(responseCode = "401", description = "Ошибка аутентификации"),
            ApiResponse(responseCode = "403", description = "Доступ запрещен"),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.POST],
        value = ["/admin/collections"],
        produces = ["application/json"],
        consumes = ["application/json"]
    )
    fun adminCollectionsPost(@Parameter(description = "", required = true) @Valid @RequestBody collection: CollectionDto): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Удаление новости",
        operationId = "adminNewsNewsIDDelete",
        description = """Удаляет новость из системы""",
        responses = [
            ApiResponse(responseCode = "204", description = "Новость успешно удалена"),
            ApiResponse(responseCode = "401", description = "Ошибка аутентификации"),
            ApiResponse(responseCode = "403", description = "Доступ запрещен"),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.DELETE],
        value = ["/admin/news/{news_ID}"],
        produces = ["application/json"]
    )
    fun adminNewsNewsIDDelete(@Parameter(description = "", required = true) @PathVariable("news_ID") newsID: kotlin.Int): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Обновление новости",
        operationId = "adminNewsNewsIDPut",
        description = """Обновляет информацию о новости""",
        responses = [
            ApiResponse(responseCode = "200", description = "Новость успешно обновлена", content = [Content(schema = Schema(implementation = NewsDto::class))]),
            ApiResponse(responseCode = "401", description = "Ошибка аутентификации"),
            ApiResponse(responseCode = "403", description = "Доступ запрещен"),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.PUT],
        value = ["/admin/news/{news_ID}"],
        produces = ["application/json"],
        consumes = ["application/json"]
    )
    fun adminNewsNewsIDPut(@Parameter(description = "", required = true) @PathVariable("news_ID") newsID: kotlin.Int,@Parameter(description = "", required = true) @Valid @RequestBody news: NewsDto): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Создание новости",
        operationId = "adminNewsPost",
        description = """Создает новую новость в системе""",
        responses = [
            ApiResponse(responseCode = "201", description = "Новость успешно создана", content = [Content(schema = Schema(implementation = NewsDto::class))]),
            ApiResponse(responseCode = "401", description = "Ошибка аутентификации"),
            ApiResponse(responseCode = "403", description = "Доступ запрещен"),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.POST],
        value = ["/admin/news"],
        produces = ["application/json"],
        consumes = ["application/json"]
    )
    fun adminNewsPost(@Parameter(description = "", required = true) @Valid @RequestBody news: NewsDto): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Удаление набор",
        operationId = "adminPacksPackIDDelete",
        description = """Удаляет набор из системы""",
        responses = [
            ApiResponse(responseCode = "204", description = "Набор успешно удален"),
            ApiResponse(responseCode = "401", description = "Ошибка аутентификации"),
            ApiResponse(responseCode = "403", description = "Доступ запрещен"),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.DELETE],
        value = ["/admin/packs/{pack_ID}"],
        produces = ["application/json"]
    )
    fun adminPacksPackIDDelete(@Parameter(description = "", required = true) @PathVariable("pack_ID") packID: kotlin.Int): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Обновление набора",
        operationId = "adminPacksPackIDPut",
        description = """Обновляет информацию о наборе""",
        responses = [
            ApiResponse(responseCode = "200", description = "Набор успешно обновлен", content = [Content(schema = Schema(implementation = PackDto::class))]),
            ApiResponse(responseCode = "401", description = "Ошибка аутентификации"),
            ApiResponse(responseCode = "403", description = "Доступ запрещен"),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.PUT],
        value = ["/admin/packs/{pack_ID}"],
        produces = ["application/json"],
        consumes = ["application/json"]
    )
    fun adminPacksPackIDPut(@Parameter(description = "", required = true) @PathVariable("pack_ID") packID: kotlin.Int,@Parameter(description = "", required = true) @Valid @RequestBody pack: PackDto): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Создание нового набора",
        operationId = "adminPacksPost",
        description = """Создает новый набор карт""",
        responses = [
            ApiResponse(responseCode = "201", description = "Набор успешно создан", content = [Content(schema = Schema(implementation = PackDto::class))]),
            ApiResponse(responseCode = "401", description = "Ошибка аутентификации"),
            ApiResponse(responseCode = "403", description = "Доступ запрещен"),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.POST],
        value = ["/admin/packs"],
        produces = ["application/json"],
        consumes = ["application/json"]
    )
    fun adminPacksPost(@Parameter(description = "", required = true) @Valid @RequestBody pack: PackDto): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Просмотр списка жалоб",
        operationId = "adminReportsGet",
        description = """Возвращает список всех жалоб в системе""",
        responses = [
            ApiResponse(responseCode = "200", description = "Список жалоб", content = [Content(array = ArraySchema(schema = Schema(implementation = ReportDto::class)))]),
            ApiResponse(responseCode = "401", description = "Ошибка аутентификации"),
            ApiResponse(responseCode = "403", description = "Доступ запрещен"),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.GET],
        value = ["/admin/reports"],
        produces = ["application/json"]
    )
    fun adminReportsGet(): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Просмотр деталей жалобы",
        operationId = "adminReportsReportIDGet",
        description = """Возвращает полную информацию о жалобе""",
        responses = [
            ApiResponse(responseCode = "200", description = "Детали жалобы", content = [Content(schema = Schema(implementation = ReportDto::class))]),
            ApiResponse(responseCode = "401", description = "Ошибка аутентификации"),
            ApiResponse(responseCode = "403", description = "Доступ запрещен"),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.GET],
        value = ["/admin/reports/{report_ID}"],
        produces = ["application/json"]
    )
    fun adminReportsReportIDGet(@Parameter(description = "", required = true) @PathVariable("report_ID") reportID: kotlin.Int): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Обновление статуса жалобы",
        operationId = "adminReportsReportIDPut",
        description = """Обновляет статус жалобы и применяет меры к пользователю""",
        responses = [
            ApiResponse(responseCode = "200", description = "Статус жалобы обновлен", content = [Content(schema = Schema(implementation = ReportDto::class))]),
            ApiResponse(responseCode = "401", description = "Ошибка аутентификации"),
            ApiResponse(responseCode = "403", description = "Доступ запрещен"),
            ApiResponse(responseCode = "404", description = "Жалоба не найдена"),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.PUT],
        value = ["/admin/reports/{report_ID}"],
        produces = ["application/json"],
        consumes = ["application/json"]
    )
    fun adminReportsReportIDPut(@Parameter(description = "", required = true) @PathVariable("report_ID") reportID: kotlin.Int,@Parameter(description = "", required = true) @Valid @RequestBody adminReportsReportIDPutRequest: AdminReportsReportIDPutRequest): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Получение статистики системы",
        operationId = "adminStatsGet",
        description = """Возвращает статистику по пользователям, картам, обменам и т.д.""",
        responses = [
            ApiResponse(responseCode = "200", description = "Статистика системы", content = [Content(schema = Schema(implementation = AdminStatsGet200Response::class))]),
            ApiResponse(responseCode = "401", description = "Ошибка аутентификации"),
            ApiResponse(responseCode = "403", description = "Доступ запрещен"),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.GET],
        value = ["/admin/stats"],
        produces = ["application/json"]
    )
    fun adminStatsGet(): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Получение списка обменов",
        operationId = "adminTradesGet",
        description = """Возвращает список всех обменов в системе""",
        responses = [
            ApiResponse(responseCode = "200", description = "Список обменов", content = [Content(array = ArraySchema(schema = Schema(implementation = TradeDto::class)))]),
            ApiResponse(responseCode = "401", description = "Ошибка аутентификации"),
            ApiResponse(responseCode = "403", description = "Доступ запрещен"),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.GET],
        value = ["/admin/trades"],
        produces = ["application/json"]
    )
    fun adminTradesGet(): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Признание обмена недействительным",
        operationId = "adminTradesTradeIDInvalidatePost",
        description = """Помечает обмен как недействительный и возвращает карты участникам
""",
        responses = [
            ApiResponse(responseCode = "200", description = "Обмен аннулирован", content = [Content(schema = Schema(implementation = AdminTradesTradeIDInvalidatePost200Response::class))]),
            ApiResponse(responseCode = "401", description = "Ошибка аутентификации"),
            ApiResponse(responseCode = "403", description = "Доступ запрещен"),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.POST],
        value = ["/admin/trades/{trade_ID}/invalidate"],
        produces = ["application/json"],
        consumes = ["application/json"]
    )
    fun adminTradesTradeIDInvalidatePost(@Parameter(description = "", required = true) @PathVariable("trade_ID") tradeID: kotlin.Int,@Parameter(description = "", required = true) @Valid @RequestBody adminTradesTradeIDInvalidatePostRequest: AdminTradesTradeIDInvalidatePostRequest): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Отзыв достижения у пользователя",
        operationId = "adminUsersUserIDAchievementsAchievementIDDelete",
        description = """Удаляет достижение из списка полученных пользователем""",
        responses = [
            ApiResponse(responseCode = "204", description = "Достижение успешно отозвано"),
            ApiResponse(responseCode = "400", description = "Неверный запрос"),
            ApiResponse(responseCode = "401", description = "Ошибка аутентификации"),
            ApiResponse(responseCode = "403", description = "Доступ запрещен"),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.DELETE],
        value = ["/admin/users/{user_id}/achievements/{achievement_ID}"],
        produces = ["application/json"]
    )
    fun adminUsersUserIDAchievementsAchievementIDDelete(@Parameter(description = "", required = true) @PathVariable("user_id") userID: kotlin.Int,@Parameter(description = "", required = true) @PathVariable("achievement_ID") achievementID: kotlin.Int): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Блокировка пользователя",
        operationId = "adminUsersUserIDBanPost",
        description = """Блокирует пользователя на указанный срок или навсегда""",
        responses = [
            ApiResponse(responseCode = "200", description = "Пользователь заблокирован", content = [Content(schema = Schema(implementation = AdminUsersUserIDBanPost200Response::class))]),
            ApiResponse(responseCode = "401", description = "Ошибка аутентификации"),
            ApiResponse(responseCode = "403", description = "Доступ запрещен"),
            ApiResponse(responseCode = "404", description = "Пользователь не найден"),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.POST],
        value = ["/admin/users/{user_id}/ban"],
        produces = ["application/json"],
        consumes = ["application/json"]
    )
    fun adminUsersUserIDBanPost(@Parameter(description = "", required = true) @PathVariable("user_id") userID: kotlin.Int,@Parameter(description = "", required = true) @Valid @RequestBody adminUsersUserIDBanPostRequest: AdminUsersUserIDBanPostRequest): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Удаление пользователя",
        operationId = "adminUsersUserIDDeleteDelete",
        description = """Полностью удаляет аккаунт пользователя из системы""",
        responses = [
            ApiResponse(responseCode = "204", description = "Пользователь успешно удален"),
            ApiResponse(responseCode = "401", description = "Ошибка аутентификации"),
            ApiResponse(responseCode = "403", description = "Доступ запрещен"),
            ApiResponse(responseCode = "404", description = "Пользователь не найден"),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.DELETE],
        value = ["/admin/users/{user_id}/delete"],
        produces = ["application/json"]
    )
    fun adminUsersUserIDDeleteDelete(@Parameter(description = "", required = true) @PathVariable("user_id") userID: kotlin.Int): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Удаление карты из инвентаря пользователя",
        operationId = "adminUsersUserIDInventoryCardIDDelete",
        description = """Удаляет конкретную карту из коллекции пользователя""",
        responses = [
            ApiResponse(responseCode = "204", description = "Карта успешно удалена из инвентаря"),
            ApiResponse(responseCode = "400", description = "Неверный запрос"),
            ApiResponse(responseCode = "401", description = "Ошибка аутентификации"),
            ApiResponse(responseCode = "403", description = "Доступ запрещен"),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.DELETE],
        value = ["/admin/users/{user_id}/inventory/{card_ID}"],
        produces = ["application/json"]
    )
    fun adminUsersUserIDInventoryCardIDDelete(@Parameter(description = "", required = true) @PathVariable("user_id") userID: kotlin.Int,@Parameter(description = "", required = true) @PathVariable("card_ID") cardID: kotlin.Int): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Сброс выполнения квеста",
        operationId = "adminUsersUserIDQuestsQuestIDResetPost",
        description = """Сбрасывает статус выполнения квеста для пользователя""",
        responses = [
            ApiResponse(responseCode = "200", description = "Квест успешно сброшен", content = [Content(schema = Schema(implementation = AdminUsersUserIDQuestsQuestIDResetPost200Response::class))]),
            ApiResponse(responseCode = "400", description = "Неверный запрос"),
            ApiResponse(responseCode = "401", description = "Ошибка аутентификации"),
            ApiResponse(responseCode = "403", description = "Доступ запрещен"),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.POST],
        value = ["/admin/users/{user_id}/quests/{quest_ID}/reset"],
        produces = ["application/json"],
        consumes = ["application/json"]
    )
    fun adminUsersUserIDQuestsQuestIDResetPost(@Parameter(description = "", required = true) @PathVariable("user_id") userID: kotlin.Int,@Parameter(description = "", required = true) @PathVariable("quest_ID") questID: kotlin.Int,@Parameter(description = "", required = true) @Valid @RequestBody adminUsersUserIDQuestsQuestIDResetPostRequest: AdminUsersUserIDQuestsQuestIDResetPostRequest): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Разблокировка пользователя",
        operationId = "adminUsersUserIDUnbanPost",
        description = """Снимает блокировку с пользователя""",
        responses = [
            ApiResponse(responseCode = "200", description = "Пользователь разблокирован", content = [Content(schema = Schema(implementation = AdminUsersUserIDUnbanPost200Response::class))]),
            ApiResponse(responseCode = "401", description = "Ошибка аутентификации"),
            ApiResponse(responseCode = "403", description = "Доступ запрещен"),
            ApiResponse(responseCode = "404", description = "Пользователь не найден"),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.POST],
        value = ["/admin/users/{user_id}/unban"],
        produces = ["application/json"]
    )
    fun adminUsersUserIDUnbanPost(@Parameter(description = "", required = true) @PathVariable("user_id") userID: kotlin.Int): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }
}
