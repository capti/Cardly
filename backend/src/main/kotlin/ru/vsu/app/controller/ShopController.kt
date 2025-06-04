package ru.vsu.app.controller

import ru.vsu.app.dto.CoinOfferDto
import ru.vsu.app.dto.PackDto
import ru.vsu.app.dto.PaymentCallbackDto
import ru.vsu.app.dto.responses.common.InternalServerError
import ru.vsu.app.dto.responses.shop.ShopCoinsOffersOfferIdPurchasePost200Response
import ru.vsu.app.dto.requests.ShopCoinsOffersOfferIdPurchasePostRequest
import ru.vsu.app.dto.responses.shop.ShopPacksPackIdBuyPost200Response
import ru.vsu.app.dto.responses.shop.ShopPacksPackIdBuyPost402Response
import ru.vsu.app.dto.responses.shop.ShopPacksPackIdOpenPost200Response
import ru.vsu.app.dto.responses.shop.ShopPaymentsProcessPost200Response
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
@Tag(name = "Shop", description = "Операции на странице \"Магазин\"")
class ShopController() {

    @Operation(
        summary = "Получение предложений по монетам",
        operationId = "shopCoinsOffersGet",
        description = """Возвращает список доступных пакетов монет
""",
        responses = [
            ApiResponse(responseCode = "200", description = "Список предложений", content = [Content(array = ArraySchema(schema = Schema(implementation = CoinOfferDto::class)))]),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ]
    )
    @RequestMapping(
        method = [RequestMethod.GET],
        value = ["/shop/coins/offers"],
        produces = ["application/json"]
    )
    fun shopCoinsOffersGet(): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Просмотр предложения монет",
        operationId = "shopCoinsOffersOfferIdGet",
        description = """Возвращает детализацию предложения по монетам
""",
        responses = [
            ApiResponse(responseCode = "200", description = "Информация о предложении", content = [Content(schema = Schema(implementation = CoinOfferDto::class))]),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ]
    )
    @RequestMapping(
        method = [RequestMethod.GET],
        value = ["/shop/coins/offers/{offer_id}"],
        produces = ["application/json"]
    )
    fun shopCoinsOffersOfferIdGet(@Parameter(description = "", required = true) @PathVariable("offer_id") offerId: kotlin.Int): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Покупка монет",
        operationId = "shopCoinsOffersOfferIdPurchasePost",
        description = """Инициирует процесс покупки монет через платежный шлюз
""",
        responses = [
            ApiResponse(responseCode = "200", description = "Перенаправление на платежный шлюз", content = [Content(schema = Schema(implementation = ShopCoinsOffersOfferIdPurchasePost200Response::class))]),
            ApiResponse(responseCode = "401", description = "Ошибка аутентификации"),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.POST],
        value = ["/shop/coins/offers/{offer_id}/purchase"],
        produces = ["application/json"],
        consumes = ["application/json"]
    )
    fun shopCoinsOffersOfferIdPurchasePost(@Parameter(description = "", required = true) @PathVariable("offer_id") offerId: kotlin.Int,@Parameter(description = "", required = true) @Valid @RequestBody shopCoinsOffersOfferIdPurchasePostRequest: ShopCoinsOffersOfferIdPurchasePostRequest): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Получение списка наборов",
        operationId = "shopPacksGet",
        description = """Возвращает список доступных для покупки наборов карт
""",
        responses = [
            ApiResponse(responseCode = "200", description = "Список наборов", content = [Content(array = ArraySchema(schema = Schema(implementation = PackDto::class)))]),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ]
    )
    @RequestMapping(
        method = [RequestMethod.GET],
        value = ["/shop/packs"],
        produces = ["application/json"]
    )
    fun shopPacksGet(): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Покупка набора карт",
        operationId = "shopPacksPackIdBuyPost",
        description = """Покупает набор карт, если:
- Пользователь авторизован
- На балансе достаточно средств
""",
        responses = [
            ApiResponse(responseCode = "200", description = "Успешная покупка", content = [Content(schema = Schema(implementation = ShopPacksPackIdBuyPost200Response::class))]),
            ApiResponse(responseCode = "401", description = "Ошибка аутентификации"),
            ApiResponse(responseCode = "402", description = "Недостаточно средств", content = [Content(schema = Schema(implementation = ShopPacksPackIdBuyPost402Response::class))]),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.POST],
        value = ["/shop/packs/{pack_id}/buy"],
        produces = ["application/json"]
    )
    fun shopPacksPackIdBuyPost(@Parameter(description = "", required = true) @PathVariable("pack_id") packId: kotlin.Int): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Просмотр содержимого набора",
        operationId = "shopPacksPackIdGet",
        description = """Возвращает подробную информацию о наборе и возможных картах
""",
        responses = [
            ApiResponse(responseCode = "200", description = "Информация о наборе", content = [Content(schema = Schema(implementation = PackDto::class))]),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ]
    )
    @RequestMapping(
        method = [RequestMethod.GET],
        value = ["/shop/packs/{pack_id}"],
        produces = ["application/json"]
    )
    fun shopPacksPackIdGet(@Parameter(description = "", required = true) @PathVariable("pack_id") packId: kotlin.Int): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Открытие купленного набора карт",
        operationId = "shopPacksPackIdOpenPost",
        description = """Открывает ранее купленный набор карт, показывая выпавшие карты
и добавляя их в инвентарь пользователя.
""",
        responses = [
            ApiResponse(responseCode = "200", description = "Набор успешно открыт", content = [Content(schema = Schema(implementation = ShopPacksPackIdOpenPost200Response::class))]),
            ApiResponse(responseCode = "401", description = "Ошибка аутентификации"),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.POST],
        value = ["/shop/packs/{pack_id}/open"],
        produces = ["application/json"]
    )
    fun shopPacksPackIdOpenPost(@Parameter(description = "", required = true) @PathVariable("pack_id") packId: kotlin.Int): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }

    @Operation(
        summary = "Обработка платежа",
        operationId = "shopPaymentsProcessPost",
        description = """обработка результата платежа от платежного шлюза
""",
        responses = [
            ApiResponse(responseCode = "200", description = "Платеж обработан", content = [Content(schema = Schema(implementation = ShopPaymentsProcessPost200Response::class))]),
            ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
        security = [ SecurityRequirement(name = "bearerAuth") ]
    )
    @RequestMapping(
        method = [RequestMethod.POST],
        value = ["/shop/payments/process"],
        produces = ["application/json"],
        consumes = ["application/json"]
    )
    fun shopPaymentsProcessPost(@Parameter(description = "", required = true) @Valid @RequestBody paymentCallback: PaymentCallbackDto): ResponseEntity<Any> {
        return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
    }
}
