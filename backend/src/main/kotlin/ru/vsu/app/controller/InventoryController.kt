// package ru.vsu.app.controller

// import ru.vsu.app.dto.responses.InventoryCardCardIDFavoriteGet200Response
// import ru.vsu.app.dto.responses.InventoryCardCardIDQuantityGet200Response
// import ru.vsu.app.dto.responses.InventoryCardCardIDTradeCancelPost200Response
// import ru.vsu.app.dto.responses.InventoryCardCardIDTradeStatusGet200Response
// import ru.vsu.app.dto.responses.InventoryDestroyPost200Response
// import ru.vsu.app.dto.requests.InventoryDestroyPostRequest
// import ru.vsu.app.dto.responses.InventoryFavoritesCountGet200Response
// import ru.vsu.app.dto.responses.InventoryGet200Response
// import ru.vsu.app.dto.responses.OtherProfileCardCardIDInitiateTradePost200Response
// import ru.vsu.app.dto.responses.common.InternalServerError
// import io.swagger.v3.oas.annotations.*
// import io.swagger.v3.oas.annotations.enums.*
// import io.swagger.v3.oas.annotations.media.*
// import io.swagger.v3.oas.annotations.responses.*
// import io.swagger.v3.oas.annotations.security.*
// import io.swagger.v3.oas.annotations.tags.Tag
// import org.springframework.http.HttpStatus
// import org.springframework.http.MediaType
// import org.springframework.http.ResponseEntity

// import org.springframework.web.bind.annotation.*
// import org.springframework.validation.annotation.Validated
// import org.springframework.web.context.request.NativeWebRequest
// import org.springframework.beans.factory.annotation.Autowired

// import jakarta.validation.Valid
// import jakarta.validation.constraints.DecimalMax
// import jakarta.validation.constraints.DecimalMin
// import jakarta.validation.constraints.Email
// import jakarta.validation.constraints.Max
// import jakarta.validation.constraints.Min
// import jakarta.validation.constraints.NotNull
// import jakarta.validation.constraints.Pattern
// import jakarta.validation.constraints.Size

// import org.springframework.security.core.annotation.AuthenticationPrincipal
// import ru.vsu.app.model.UserEntity
// import ru.vsu.app.service.InventoryService
// import ru.vsu.app.dto.responses.CardResponse

// import kotlin.collections.List
// import kotlin.collections.Map

// @RestController
// @Validated
// @RequestMapping("\${api.base-path:/api}")
// @SecurityRequirement(name = "Bearer Authentication")
// @Tag(name = "Inventory", description = "Операции на странице \"Инвентарь\"")
// class InventoryController(private val inventoryService: InventoryService) {

//     @Operation(
//         summary = "Добавление карты в избранное",
//         operationId = "inventoryCardCardIDFavoriteAddPost",
//         description = """Добавляет карту в избранное, если:
// - Карта не добавлена в "избранное"
// - Общее количество избранных карт < 5
// """,
//         responses = [
//             ApiResponse(responseCode = "200", description= "Карта успешно добавлена в избранное"),
//             ApiResponse(responseCode = "400", description = "Невозможно добавить карту в избранное"),
//             ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
//         security = [ SecurityRequirement(name = "bearerAuth") ]
//     )
//     @RequestMapping(
//         method = [RequestMethod.POST],
//         value = ["/inventory/card/{card_ID}/favorite-add"],
//         produces = ["application/json"]
//     )
//     fun inventoryCardCardIDFavoriteAddPost(@Parameter(description = "", required = true) @PathVariable("card_ID") cardID: kotlin.Int): ResponseEntity<Any> {
//         return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
//     }

//     @Operation(
//         summary = "Удаление карты из избранного",
//         operationId = "inventoryCardCardIDFavoriteDeleteDelete",
//         description = """Удаляет карту из избранного.
// """,
//         responses = [
//             ApiResponse(responseCode = "200", description = "Карта успешно удалена из избранного"),
//             ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
//         security = [ SecurityRequirement(name = "bearerAuth") ]
//     )
//     @RequestMapping(
//         method = [RequestMethod.DELETE],
//         value = ["/inventory/card/{card_ID}/favorite-delete"],
//         produces = ["application/json"]
//     )
//     fun inventoryCardCardIDFavoriteDeleteDelete(@Parameter(description = "", required = true) @PathVariable("card_ID") cardID: kotlin.Int): ResponseEntity<Any> {
//         return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
//     }

//     @Operation(
//         summary = "Проверка статуса карты",
//         operationId = "inventoryCardCardIDFavoriteGet",
//         description = """Проверяет, добавлена ли карта в избранное.
// """,
//         responses = [
//             ApiResponse(responseCode = "200", description = "Статус избранного", content = [Content(schema = Schema(implementation = InventoryCardCardIDFavoriteGet200Response::class))]),
//             ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
//         security = [ SecurityRequirement(name = "bearerAuth") ]
//     )
//     @RequestMapping(
//         method = [RequestMethod.GET],
//         value = ["/inventory/card/{card_ID}/favorite"],
//         produces = ["application/json"]
//     )
//     fun inventoryCardCardIDFavoriteGet(@Parameter(description = "", required = true) @PathVariable("card_ID") cardID: kotlin.Int): ResponseEntity<Any> {
//         return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
//     }

//     @Operation(
//         summary = "Проверка количества экземпляров карты",
//         operationId = "inventoryCardCardIDQuantityGet",
//         description = """Возвращает количество экземпляров карты у пользователя.
// Если экземпляров больше 1 - можно разбирать/выставлять на обмен.
// """,
//         responses = [
//             ApiResponse(responseCode = "200", description = "Информация о количестве карт", content = [Content(schema = Schema(implementation = InventoryCardCardIDQuantityGet200Response::class))]),
//             ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
//         security = [ SecurityRequirement(name = "bearerAuth") ]
//     )
//     @RequestMapping(
//         method = [RequestMethod.GET],
//         value = ["/inventory/card/{card_ID}/quantity"],
//         produces = ["application/json"]
//     )
//     fun inventoryCardCardIDQuantityGet(@Parameter(description = "", required = true) @PathVariable("card_ID") cardID: kotlin.Int): ResponseEntity<Any> {
//         return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
//     }

//     @Operation(
//         summary = "Снятие карты с обмена",
//         operationId = "inventoryCardCardIDTradeCancelPost",
//         description = """Возвращает карту из раздела "На обмен" в Инвентарь""",
//         responses = [
//             ApiResponse(responseCode = "200", description = "Карта успешно снята с обмена", content = [Content(schema = Schema(implementation = InventoryCardCardIDTradeCancelPost200Response::class))]),
//             ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
//         security = [ SecurityRequirement(name = "bearerAuth") ]
//     )
//     @RequestMapping(
//         method = [RequestMethod.POST],
//         value = ["/inventory/card/{card_ID}/trade-cancel"],
//         produces = ["application/json"]
//     )
//     fun inventoryCardCardIDTradeCancelPost(@Parameter(description = "", required = true) @PathVariable("card_ID") cardID: kotlin.Int): ResponseEntity<Any> {
//         return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
//     }

//     @Operation(
//         summary = "Проверка статуса обмена карты",
//         operationId = "inventoryCardCardIDTradeStatusGet",
//         description = """Проверяет, выставлена ли карта на обмен.
// Возвращает статус карты.
// """,
//         responses = [
//             ApiResponse(responseCode = "200", description = "Статус обмена карты", content = [Content(schema = Schema(implementation = InventoryCardCardIDTradeStatusGet200Response::class))]),
//             ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
//         security = [ SecurityRequirement(name = "bearerAuth") ]
//     )
//     @RequestMapping(
//         method = [RequestMethod.GET],
//         value = ["/inventory/card/{card_ID}/trade-status"],
//         produces = ["application/json"]
//     )
//     fun inventoryCardCardIDTradeStatusGet(@Parameter(description = "", required = true) @PathVariable("card_ID") cardID: kotlin.Int): ResponseEntity<Any> {
//         return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
//     }

//     @Operation(
//         summary = "Разбор карты на валюту",
//         operationId = "inventoryDestroyPost",
//         description = """Разбирает карту на валюту, если:
// - У пользователя есть минимум 2 экземпляра этой карты
// - Добавляет стоимость карты на баланс пользователя
// """,
//         responses = [
//             ApiResponse(responseCode = "200", description = "Карта успешно разобрана", content = [Content(schema = Schema(implementation = InventoryDestroyPost200Response::class))]),
//             ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
//         security = [ SecurityRequirement(name = "bearerAuth") ]
//     )
//     @RequestMapping(
//         method = [RequestMethod.POST],
//         value = ["/inventory/destroy"],
//         produces = ["application/json"],
//         consumes = ["application/json"]
//     )
//     fun inventoryDestroyPost(@Parameter(description = "", required = true) @Valid @RequestBody inventoryDestroyPostRequest: InventoryDestroyPostRequest): ResponseEntity<Any> {
//         return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
//     }

//     @Operation(
//         summary = "Получение количества избранных карт",
//         operationId = "inventoryFavoritesCountGet",
//         description = """Возвращает текущее количество избранных карт.
// Если количество меньше 5 - можно добавлять новые карты в избранное.
// """,
//         responses = [
//             ApiResponse(responseCode = "200", description = "Количество избранных карт", content = [Content(schema = Schema(implementation = InventoryFavoritesCountGet200Response::class))]),
//             ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
//         security = [ SecurityRequirement(name = "bearerAuth") ]
//     )
//     @RequestMapping(
//         method = [RequestMethod.GET],
//         value = ["/inventory/favorites/count"],
//         produces = ["application/json"]
//     )
//     fun inventoryFavoritesCountGet(): ResponseEntity<Any> {
//         return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
//     }

//     @Operation(
//         summary = "Получение данных инвентаря",
//         operationId = "inventoryGet",
//         description = """Загружает данные инвентаря пользователя.
// - Проверяет авторизацию пользователя
// - Если пользователь не авторизован - возвращает ошибку 401
// - Если авторизован - возвращает список его карт, список избранных карт и баланс 
// """,
//         responses = [
//             ApiResponse(responseCode = "200", description = "Успешная загрузка инвентаря", content = [Content(schema = Schema(implementation = InventoryGet200Response::class))]),
//             ApiResponse(responseCode = "401", description = "Ошибка аутентификации"),
//             ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
//         security = [ SecurityRequirement(name = "bearerAuth") ]
//     )
//     @RequestMapping(
//         method = [RequestMethod.GET],
//         value = ["/inventory"],
//         produces = ["application/json"]
//     )
//     fun inventoryGet(
//         @AuthenticationPrincipal user: UserEntity
//     ): ResponseEntity<Any> {
//         val inventoryData = inventoryService.getInventoryData(user)
//         return ResponseEntity.ok(inventoryData)
//     }

//     @Operation(
//         summary = "Выставление карты на обмен",
//         operationId = "inventoryPutOnTradePost",
//         description = """Выставляет карту на обмен, если:
// - У пользователя есть минимум 2 экземпляра этой карты
// - Карта еще не выставлена на обмен
// """,
//         responses = [
//             ApiResponse(responseCode = "200", description = "Карта готова к обмену", content = [Content(schema = Schema(implementation = OtherProfileCardCardIDInitiateTradePost200Response::class))]),
//             ApiResponse(responseCode = "400", description = "Невозможно выставить карту на обмен"),
//             ApiResponse(responseCode = "500", description = "Что-то пошло не так", content = [Content(schema = Schema(implementation = InternalServerError::class))]) ],
//         security = [ SecurityRequirement(name = "bearerAuth") ]
//     )
//     @RequestMapping(
//         method = [RequestMethod.POST],
//         value = ["/inventory/put-on-trade"],
//         produces = ["application/json"],
//         consumes = ["application/json"]
//     )
//     fun inventoryPutOnTradePost(@Parameter(description = "", required = true) @Valid @RequestBody inventoryDestroyPostRequest: InventoryDestroyPostRequest): ResponseEntity<Any> {
//         return ResponseEntity(HttpStatus.NOT_IMPLEMENTED)
//     }
// }
