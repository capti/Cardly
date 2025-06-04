// package ru.vsu.app.controller

// import io.swagger.v3.oas.annotations.Operation
// import io.swagger.v3.oas.annotations.Parameter
// import io.swagger.v3.oas.annotations.tags.Tag
// import org.springframework.http.HttpStatus
// import org.springframework.http.ResponseEntity
// import org.springframework.security.core.annotation.AuthenticationPrincipal
// import org.springframework.validation.annotation.Validated
// import org.springframework.web.bind.annotation.*
// import ru.vsu.app.dto.*
// import ru.vsu.app.model.UserEntity
// import ru.vsu.app.service.ShopService
// import jakarta.validation.Valid

// @RestController
// @RequestMapping("/api/shop")
// @Tag(name = "Shop", description = "API для работы с магазином")
// @Validated
// class ShopController(private val shopService: ShopService) {

//     @Operation(summary = "Получение списка наборов карт", description = "Возвращает список доступных для покупки наборов карт")
//     @GetMapping("/packs")
//     fun getAllPacks(): ResponseEntity<Any> {
//         val packs = shopService.getAllPacks()
//         return ResponseEntity.ok(packs)
//     }

//     @Operation(summary = "Получение информации о наборе карт", description = "Возвращает подробную информацию о наборе и его содержимом")
//     @GetMapping("/packs/{packId}")
//     fun getPackDetails(
//         @Parameter(description = "ID набора карт", required = true)
//         @PathVariable packId: Long
//     ): ResponseEntity<Any> {
//         val pack = shopService.getPackDetails(packId)
//         return ResponseEntity.ok(pack)
//     }

//     @Operation(summary = "Покупка набора карт", description = "Покупает набор карт, если пользователь авторизован и на балансе достаточно средств")
//     @PostMapping("/packs/{packId}/buy")
//     fun buyPack(
//         @Parameter(description = "ID набора карт", required = true)
//         @PathVariable packId: Long,
//         @AuthenticationPrincipal user: UserEntity
//     ): ResponseEntity<Any> {
//         return ResponseEntity.ok(shopService.buyPack(packId, user))
//     }

//     @Operation(summary = "Получение списка предложений монет", description = "Возвращает список доступных пакетов монет")
//     @GetMapping("/coins/offers")
//     fun getAllCoinOffers(): ResponseEntity<Any> {
//         val offers = shopService.getAllCoinOffers()
//         return ResponseEntity.ok(offers)
//     }

//     @Operation(summary = "Получение информации о предложении монет", description = "Возвращает детализацию конкретного предложения монет")
//     @GetMapping("/coins/offers/{offerId}")
//     fun getCoinOfferDetails(
//         @Parameter(description = "ID предложения монет", required = true)
//         @PathVariable offerId: Long
//     ): ResponseEntity<Any> {
//         val offer = shopService.getCoinOfferDetails(offerId)
//         return ResponseEntity.ok(offer)
//     }

//     data class PurchaseCoinsRequest(
//         @Parameter(description = "URL для редиректа после покупки", required = true)
//         val redirectUrl: String
//     )

//     @Operation(summary = "Покупка монет", description = "Инициирует процесс покупки монет через платежный шлюз")
//     @PostMapping("/coins/offers/{offerId}/purchase")
//     fun purchaseCoins(
//         @Parameter(description = "ID предложения монет", required = true)
//         @PathVariable offerId: Long,
//         @Valid @RequestBody request: PurchaseCoinsRequest
//     ): ResponseEntity<Any> {
//         val purchaseResponse = shopService.purchaseCoins(offerId, request.redirectUrl)
//         return ResponseEntity.ok(purchaseResponse)
//     }

//     @Operation(summary = "Обработка платежа", description = "Обрабатывает результат платежа от платежного шлюза")
//     @PostMapping("/payments/process")
//     fun processPayment(
//         @Valid @RequestBody request: PaymentCallbackRequest
//     ): ResponseEntity<Any> {
//         val success = shopService.processPayment(request)
//         return ResponseEntity.ok(mapOf("success" to success))
//     }
// }
