// package ru.vsu.app.service

// import org.springframework.stereotype.Service
// import org.springframework.transaction.annotation.Transactional
// import ru.vsu.app.dto.responses.CardResponse
// import ru.vsu.app.dto.responses.InventoryGet200Response
// import ru.vsu.app.dto.responses.InventorySortPost200Response
// import ru.vsu.app.dto.requests.OtherProfileInventorySortPostRequest
// import ru.vsu.app.model.CardEntity
// import ru.vsu.app.model.UserEntity
// import ru.vsu.app.repository.InventoryRepository
// import ru.vsu.app.repository.UserRepository
// import jakarta.persistence.EntityNotFoundException

// @Service
// class InventoryService(
//     private val InventoryRepository: InventoryRepository,
//     private val userRepository: UserRepository
// ) {
//     fun getUserCards(user: UserEntity, sortBy: String = "rarity"): List<CardResponse> {
//         val cards = when (sortBy) {
//             "rarity" -> InventoryRepository.findAllByOwnerOrderByRarityDesc(user)
//             "collection" -> InventoryRepository.findAllByOwnerOrderByCollectionAsc(user)
//             else -> InventoryRepository.findAllByOwner(user)
//         }
        
//         return cards.map { card -> mapToCardResponse(card) }
//     }

//     fun getCardDetails(cardId: Long, user: UserEntity): CardResponse {
//         val card = InventoryRepository.findById(cardId)
//             .orElseThrow { EntityNotFoundException("Card not found with id: $cardId") }
        
//         if (card.owner?.id != user.id) {
//             throw IllegalStateException("User does not own this card")
//         }
        
//         return mapToCardResponse(card)
//     }

//     @Transactional
//     fun disassembleCard(cardId: Long, user: UserEntity): Int {
//         val card = InventoryRepository.findById(cardId)
//             .orElseThrow { EntityNotFoundException("Card not found with id: $cardId") }
        
//         if (card.owner?.id != user.id) {
//             throw IllegalStateException("User does not own this card")
//         }

//         // Add coins to user's balance
//         val updatedUser = user.copy(coins = user.coins + card.disassemblePrice)
//         userRepository.save(updatedUser)

//         // Delete the card
//         InventoryRepository.delete(card)

//         return card.disassemblePrice
//     }


//     fun getInventoryData(user: UserEntity): InventoryGet200Response {
//         val allCards = InventoryRepository.findAllByOwner(user)
//         val favoriteCards = allCards.filter { it.isFavorite == true }
//         return InventoryGet200Response(
//             cards = allCards.map { mapToCardResponse(it) },
//             favorites = favoriteCards.map { mapToCardResponse(it) },
//             balance = user.coins
//         )
//     }

//     private fun mapToCardResponse(card: CardEntity): CardResponse {
//         return CardResponse(
//             id = card.id,
//             name = card.name,
//             imageUrl = card.imageUrl,
//             rarity = card.rarity,
//             collection = card.collection,
//             description = card.description,
//             type = card.type,
//             disassemblePrice = card.disassemblePrice
//         )
//     }
// }