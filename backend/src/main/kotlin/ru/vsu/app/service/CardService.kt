package ru.vsu.app.service

import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import ru.vsu.app.dto.CardResponse
import ru.vsu.app.model.Card
import ru.vsu.app.model.User
import ru.vsu.app.repository.CardRepository
import ru.vsu.app.repository.UserRepository
import jakarta.persistence.EntityNotFoundException

@Service
class CardService(
    private val cardRepository: CardRepository,
    private val userRepository: UserRepository
) {
    fun getUserCards(user: User, sortBy: String = "rarity"): List<CardResponse> {
        val cards = when (sortBy) {
            "rarity" -> cardRepository.findAllByOwnerOrderByRarityDesc(user)
            "collection" -> cardRepository.findAllByOwnerOrderByCollectionAsc(user)
            else -> cardRepository.findAllByOwner(user)
        }
        
        return cards.map { card -> mapToCardResponse(card) }
    }

    fun getCardDetails(cardId: Long, user: User): CardResponse {
        val card = cardRepository.findById(cardId)
            .orElseThrow { EntityNotFoundException("Card not found with id: $cardId") }
        
        if (card.owner?.id != user.id) {
            throw IllegalStateException("User does not own this card")
        }
        
        return mapToCardResponse(card)
    }

    @Transactional
    fun disassembleCard(cardId: Long, user: User): Int {
        val card = cardRepository.findById(cardId)
            .orElseThrow { EntityNotFoundException("Card not found with id: $cardId") }
        
        if (card.owner?.id != user.id) {
            throw IllegalStateException("User does not own this card")
        }

        // Add coins to user's balance
        val updatedUser = user.copy(coins = user.coins + card.disassemblePrice)
        userRepository.save(updatedUser)

        // Delete the card
        cardRepository.delete(card)

        return card.disassemblePrice
    }

    private fun mapToCardResponse(card: Card): CardResponse {
        return CardResponse(
            id = card.id,
            name = card.name,
            imageUrl = card.imageUrl,
            rarity = card.rarity,
            collection = card.collection,
            description = card.description,
            type = card.type,
            disassemblePrice = card.disassemblePrice
        )
    }
} 