package ru.vsu.app.controller

import org.springframework.http.ResponseEntity
import org.springframework.security.core.annotation.AuthenticationPrincipal
import org.springframework.web.bind.annotation.*
import ru.vsu.app.dto.CardResponse
import ru.vsu.app.model.User
import ru.vsu.app.service.CardService

@RestController
@RequestMapping("/api/cards")
class CardController(
    private val cardService: CardService
) {
    @GetMapping("/inventory")
    fun getUserInventory(
        @AuthenticationPrincipal user: User,
        @RequestParam(required = false, defaultValue = "rarity") sortBy: String
    ): ResponseEntity<List<CardResponse>> {
        val cards = cardService.getUserCards(user, sortBy)
        return ResponseEntity.ok(cards)
    }

    @GetMapping("/{cardId}")
    fun getCardDetails(
        @PathVariable cardId: Long,
        @AuthenticationPrincipal user: User
    ): ResponseEntity<CardResponse> {
        val card = cardService.getCardDetails(cardId, user)
        return ResponseEntity.ok(card)
    }

    @PostMapping("/{cardId}/disassemble")
    fun disassembleCard(
        @PathVariable cardId: Long,
        @AuthenticationPrincipal user: User
    ): ResponseEntity<Map<String, Int>> {
        val coinsReceived = cardService.disassembleCard(cardId, user)
        return ResponseEntity.ok(mapOf("coinsReceived" to coinsReceived))
    }
} 