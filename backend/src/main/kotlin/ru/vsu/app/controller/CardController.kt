// package ru.vsu.app.controller

// import org.springframework.http.ResponseEntity
// import org.springframework.security.core.annotation.AuthenticationPrincipal
// import org.springframework.web.bind.annotation.*
// import io.swagger.v3.oas.annotations.tags.Tag
// import io.swagger.v3.oas.annotations.Operation
// import io.swagger.v3.oas.annotations.Parameter
// import io.swagger.v3.oas.annotations.media.Content
// import io.swagger.v3.oas.annotations.media.Schema
// import io.swagger.v3.oas.annotations.responses.ApiResponse
// import ru.vsu.app.dto.CardDto
// import ru.vsu.app.model.UserEntity
// import ru.vsu.app.service.InventoryService

//@SecurityRequirement(name = "Bearer Authentication")
// @RestController
// @RequestMapping("/api/card")
// @Tag(name = "Card", description = "Функции, связанные с карточками пользователя")
// class CardController(
//     private val cardService: InventoryService
// ) {

//     // @Operation(
//     //     summary = "Получить инвентарь пользователя",
//     //     description = "Возвращает список карточек, принадлежащих пользователю. Можно указать параметр сортировки (по умолчанию — по редкости).",
//     //     parameters = [
//     //         Parameter(name = "sortBy", description = "Критерий сортировки (rarity, name, и т.д.)", required = false)
//     //     ],
//     //     responses = [
//     //         ApiResponse(responseCode = "200", description = "Список карточек успешно получен",
//     //             content = [Content(mediaType = "application/json", schema = Schema(implementation = CardResponse::class))])
//     //     ]
//     // )
//     // @GetMapping("/inventory")
//     // fun getUserInventory(
//     //     @AuthenticationPrincipal user: UserEntity,
//     //     @RequestParam(required = false, defaultValue = "rarity") sortBy: String
//     // ): ResponseEntity<Any> {
//     //     val cards = cardService.getUserCards(user, sortBy)
//     //     return ResponseEntity.ok(cards)
//     // }

//     @Operation(
//         summary = "Получить подробную информацию о карточке",
//         description = "Возвращает подробные сведения о конкретной карточке пользователя по её ID.",
//         parameters = [
//             Parameter(name = "cardId", description = "ID карточки", required = true)
//         ],
//         responses = [
//             ApiResponse(responseCode = "200", description = "Карточка успешно получена",
//                 content = [Content(mediaType = "application/json", schema = Schema(implementation = CardResponse::class))]),
//             ApiResponse(responseCode = "404", description = "Карточка не найдена")
//         ]
//     )
//     @GetMapping("/{cardId}")
//     fun getCardDetails(
//         @PathVariable cardId: Long,
//         @AuthenticationPrincipal user: UserEntity
//     ): ResponseEntity<Any> {
//         val card = cardService.getCardDetails(cardId, user)
//         return ResponseEntity.ok(card)
//     }

//     @Operation(
//         summary = "Разобрать карточку на монеты",
//         description = "Позволяет пользователю разобрать карточку и получить за неё внутриигровую валюту.",
//         parameters = [
//             Parameter(name = "cardId", description = "ID карточки", required = true)
//         ],
//         responses = [
//             ApiResponse(responseCode = "200", description = "Карточка успешно разобрана",
//                 content = [Content(mediaType = "application/json", schema = Schema(example = """{"coinsReceived": 100}"""))]),
//             ApiResponse(responseCode = "400", description = "Невозможно разобрать карточку"),
//             ApiResponse(responseCode = "404", description = "Карточка не найдена")
//         ]
//     )
//     @PostMapping("/{cardId}/disassemble")
//     fun disassembleCard(
//         @PathVariable cardId: Long,
//         @AuthenticationPrincipal user: UserEntity
//     ): ResponseEntity<Any> {
//         val coinsReceived = cardService.disassembleCard(cardId, user)
//         return ResponseEntity.ok(mapOf("coinsReceived" to coinsReceived))
//     }
// }
