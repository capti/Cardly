package ru.vsu.app.controller

import ru.vsu.app.dto.responses.profile.OtherProfileCardCardIDInitiateTradePost400Response
import ru.vsu.app.dto.responses.common.InternalServerError
import ru.vsu.app.dto.TradeDto
import ru.vsu.app.dto.requests.TradesInitiatePostRequest
import ru.vsu.app.dto.responses.trades.TradesTradeIdAcceptPost200Response
import ru.vsu.app.dto.responses.trades.TradesTradeIdAcceptPost403Response
import ru.vsu.app.dto.responses.trades.TradesTradeIdCancelPost200Response
import ru.vsu.app.dto.responses.trades.TradesTradeIdGet404Response
import ru.vsu.app.dto.responses.trades.TradesTradeIdRejectPost200Response
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
@SecurityRequirement(name = "Bearer Authentication")
@RequestMapping("\${api.base-path:/api}")
@Tag(name = "Trades", description = "Операции на странице \"Обменник\"")
class TradesController() {

    @Operation(
        summary = "Получить все доступные предложения обмена",
        operationId = "tradesGet",
        description = """Возвращает список всех доступных предложений обмена.
Можно провести поиск по названию карты.
""",
        responses = [
            ApiResponse(responseCode = "200", description = "Список предложений обмена", content = [Content(array = ArraySchema(schema = Schema(implementation = TradeDto::class)))]),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ]
    )
    @RequestMapping(
        method = [RequestMethod.GET],
        value = ["/trades"],
        produces = ["application/json"]
    )
    fun tradesGet( @RequestParam(value = "search", required = false) search: kotlin.String?): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Создать новое предложение обмена",
        operationId = "tradesInitiatePost",
        description = """Создает новое предложение обмена.
""",
        responses = [
            ApiResponse(responseCode = "201", description = "Предложение обмена успешно создано", content = [Content(schema = Schema(implementation = TradeDto::class))]),
            ApiResponse(responseCode = "400", description = "Невозможно создать предложение обмена", content = [Content(schema = Schema(implementation = OtherProfileCardCardIDInitiateTradePost400Response::class))]),
            ApiResponse(responseCode = "401", description = "Ошибка аутентификации"),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.POST],
        value = ["/trades/initiate"],
        produces = ["application/json"],
        consumes = ["application/json"]
    )
    fun tradesInitiatePost(@Parameter(description = "", required = true) @Valid @RequestBody tradesInitiatePostRequest: TradesInitiatePostRequest): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Получение моих обменов",
        operationId = "tradesMyGet",
        description = """Возвращает список всех обменов текущего пользователя с их статусами.
""",
        responses = [
            ApiResponse(responseCode = "200", description = "Список моих обменов", content = [Content(array = ArraySchema(schema = Schema(implementation = TradeDto::class)))]),
            ApiResponse(responseCode = "401", description = "Ошибка аутентификации"),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.GET],
        value = ["/trades/my"],
        produces = ["application/json"]
    )
    fun tradesMyGet( @RequestParam(value = "user_id", required = true) userId: kotlin.Int): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Принять предложение обмена",
        operationId = "tradesTradeIdAcceptPost",
        description = """Принимает предложение обмена, если текущий пользователь - получатель обмена.
""",
        responses = [
            ApiResponse(responseCode = "200", description = "Обмен успешно принят", content = [Content(schema = Schema(implementation = TradesTradeIdAcceptPost200Response::class))]),
            ApiResponse(responseCode = "401", description = "Ошибка аутентификации"),
            ApiResponse(responseCode = "403", description = "Нет прав для принятия этого обмена", content = [Content(schema = Schema(implementation = TradesTradeIdAcceptPost403Response::class))]),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.POST],
        value = ["/trades/{trade_id}/accept"],
        produces = ["application/json"]
    )
    fun tradesTradeIdAcceptPost(@Parameter(description = "", required = true) @PathVariable("trade_id") tradeId: kotlin.Int): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Отменить предложение обмена",
        operationId = "tradesTradeIdCancelPost",
        description = """Отменяет предложение обмена, если текущий пользователь является инициатором.
""",
        responses = [
            ApiResponse(responseCode = "200", description = "Обмен успешно отменен", content = [Content(schema = Schema(implementation = TradesTradeIdCancelPost200Response::class))]),
            ApiResponse(responseCode = "401", description = "Ошибка аутентификации"),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.POST],
        value = ["/trades/{trade_id}/cancel"],
        produces = ["application/json"]
    )
    fun tradesTradeIdCancelPost(@Parameter(description = "", required = true) @PathVariable("trade_id") tradeId: kotlin.Int): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Получить детали предложения обмена",
        operationId = "tradesTradeIdGet",
        description = """Возвращает полную информацию о конкретном предложении обмена.
""",
        responses = [
            ApiResponse(responseCode = "200", description = "Детали предложения обмена", content = [Content(schema = Schema(implementation = TradeDto::class))]),
            ApiResponse(responseCode = "404", description = "Предложение обмена не найдено", content = [Content(schema = Schema(implementation = TradesTradeIdGet404Response::class))]),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ]
    )
    @RequestMapping(
        method = [RequestMethod.GET],
        value = ["/trades/{trade_id}"],
        produces = ["application/json"]
    )
    fun tradesTradeIdGet(@Parameter(description = "", required = true) @PathVariable("trade_id") tradeId: kotlin.Int): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Отклонить предложение обмена",
        operationId = "tradesTradeIdRejectPost",
        description = """Отклоняет предложение обмена, если текущий пользователь - получатель обмена.
""",
        responses = [
            ApiResponse(responseCode = "200", description = "Обмен успешно отклонен", content = [Content(schema = Schema(implementation = TradesTradeIdRejectPost200Response::class))]),
            ApiResponse(responseCode = "401", description = "Ошибка аутентификации"),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.POST],
        value = ["/trades/{trade_id}/reject"],
        produces = ["application/json"]
    )
    fun tradesTradeIdRejectPost(@Parameter(description = "", required = true) @PathVariable("trade_id") tradeId: kotlin.Int): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }
}
