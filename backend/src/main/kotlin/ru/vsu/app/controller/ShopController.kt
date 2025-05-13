package ru.vsu.app.controller

import io.swagger.v3.oas.annotations.Operation
import io.swagger.v3.oas.annotations.tags.Tag
import org.springframework.http.ResponseEntity
import org.springframework.security.core.annotation.AuthenticationPrincipal
import org.springframework.web.bind.annotation.*
import ru.vsu.app.dto.*
import ru.vsu.app.model.User
import ru.vsu.app.service.ShopService

@RestController
@RequestMapping("/api/shop")
@Tag(name = "Shop", description = "API для работы с магазином")
class ShopController(private val shopService: ShopService) {

    @Operation(summary = "Получение списка наборов")
    @GetMapping("/packs")
    fun getAllPacks(): ResponseEntity<List<PackResponse>> {
        return ResponseEntity.ok(shopService.getAllPacks())
    }

    @Operation(summary = "Получение информации о наборе")
    @GetMapping("/packs/{packId}")
    fun getPackDetails(@PathVariable packId: Long): ResponseEntity<PackResponse> {
        return ResponseEntity.ok(shopService.getPackDetails(packId))
    }

    @Operation(summary = "Покупка набора")
    @PostMapping("/packs/{packId}/buy")
    fun buyPack(
        @PathVariable packId: Long,
        @AuthenticationPrincipal user: User
    ): ResponseEntity<PurchasePackResponse> {
        return ResponseEntity.ok(shopService.buyPack(packId, user))
    }

    @Operation(summary = "Получение списка предложений монет")
    @GetMapping("/coins/offers")
    fun getAllCoinOffers(): ResponseEntity<List<CoinOfferResponse>> {
        return ResponseEntity.ok(shopService.getAllCoinOffers())
    }

    @Operation(summary = "Получение информации о предложении монет")
    @GetMapping("/coins/offers/{offerId}")
    fun getCoinOfferDetails(@PathVariable offerId: Long): ResponseEntity<CoinOfferResponse> {
        return ResponseEntity.ok(shopService.getCoinOfferDetails(offerId))
    }

    @Operation(summary = "Покупка монет")
    @PostMapping("/coins/offers/{offerId}/purchase")
    fun purchaseCoins(
        @PathVariable offerId: Long,
        @RequestBody request: Map<String, String>
    ): ResponseEntity<PurchaseCoinsResponse> {
        val redirectUrl = request["redirectUrl"] ?: throw IllegalArgumentException("redirectUrl is required")
        return ResponseEntity.ok(shopService.purchaseCoins(offerId, redirectUrl))
    }

    @Operation(summary = "Обработка платежа")
    @PostMapping("/payments/process")
    fun processPayment(@RequestBody request: PaymentCallbackRequest): ResponseEntity<Map<String, Boolean>> {
        val success = shopService.processPayment(request)
        return ResponseEntity.ok(mapOf("success" to success))
    }
} 