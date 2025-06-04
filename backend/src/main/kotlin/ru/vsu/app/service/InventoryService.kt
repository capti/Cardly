package ru.vsu.app.service

import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional

import ru.vsu.app.dto.responses.inventory.InventoryGet200Response

import ru.vsu.app.model.CardEntity
import ru.vsu.app.model.UserEntity

import ru.vsu.app.repository.InventoryRepository
import ru.vsu.app.repository.CollectionRepository
import ru.vsu.app.repository.UserRepository

import ru.vsu.app.mapper.CardMapper
import ru.vsu.app.mapper.CollectionMapper

import jakarta.persistence.EntityNotFoundException

@Service
class InventoryService(
    private val inventoryRepository: InventoryRepository,
    private val userRepository: UserRepository,
    private val collectionMapper: CollectionMapper,
    private val collectionRepository: CollectionRepository,
    private val cardMapper: CardMapper
) {
    
    // fun getUserCards(user: UserEntity, sortBy: String = "rarity"): List<CardResponse> {
    //     val cards = when (sortBy) {
    //         "rarity" -> InventoryRepository.findAllByOwnerOrderByRarityDesc(user)
    //         "collection" -> InventoryRepository.findAllByOwnerOrderByCollectionAsc(user)
    //         else -> InventoryRepository.findAllByOwner(user)
    //     }
        
    //     return cards.map { card -> mapToCardResponse(card) }
    // }

    // fun getCardDetails(cardId: Long, user: UserEntity): CardResponse {
    //     val card = InventoryRepository.findById(cardId)
    //         .orElseThrow { EntityNotFoundException("Card not found with id: $cardId") }
        
    //     if (card.owner?.id != user.id) {
    //         throw IllegalStateException("User does not own this card")
    //     }
        
    //     return mapToCardResponse(card)
    // }

    // @Transactional
    // fun disassembleCard(cardId: Long, user: UserEntity): Int {
    //     val card = InventoryRepository.findById(cardId)
    //         .orElseThrow { EntityNotFoundException("Card not found with id: $cardId") }
        
    //     if (card.owner?.id != user.id) {
    //         throw IllegalStateException("User does not own this card")
    //     }

    //     // Add coins to user's balance
    //     val updatedUser = user.copy(coins = user.coins + card.disassemblePrice)
    //     userRepository.save(updatedUser)

    //     // Delete the card
    //     InventoryRepository.delete(card)

    //     return card.disassemblePrice
    // }


    fun getInventoryData(user: UserEntity): InventoryGet200Response {
        val allCards = user.inventoryCards
        val favoriteCards = user.favoriteCards
        val inventoryDtos = allCards.map { cardMapper.toDto(it) }
        val completedColls = user.completedCollections
        val collectionDtos = completedColls.map { collectionMapper.toDto(it) }

        return InventoryGet200Response(
            inventory = inventoryDtos,
            favoriteCards = favoriteCards.map { it.id },
            collections = collectionDtos,
            balance = user.balance
        )
    }
}