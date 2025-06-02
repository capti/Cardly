// package ru.vsu.app.service

// import org.springframework.stereotype.Service
// import org.springframework.transaction.annotation.Transactional
// import ru.vsu.app.dto.responses.*
// import ru.vsu.app.model.UserEntity
// import ru.vsu.app.model.CardEntity
// import ru.vsu.app.model.PackEntity
// import ru.vsu.app.model.CoinOfferEntity
// import ru.vsu.app.repository.PackRepository
// import ru.vsu.app.repository.CoinOfferRepository
// import ru.vsu.app.repository.UserRepository
// import ru.vsu.app.repository.InventoryRepository
// import jakarta.persistence.EntityNotFoundException

// @Service
// class ShopService(
//     private val packRepository: PackRepository,
//     private val coinOfferRepository: CoinOfferRepository,
//     private val userRepository: UserRepository,
//     private val InventoryRepository: InventoryRepository
// ) {
//     fun getAllPacks(): List<PackResponse> {
//         return packRepository.findAll().map { pack: PackEntity ->
//             PackResponse(
//                 id = pack.id,
//                 name = pack.name,
//                 imageUrl = pack.imageUrl,
//                 price = pack.price,
//                 cards = pack.cards.map { card: CardEntity ->
//                     CardResponse(
//                         id = card.id,
//                         name = card.name,
//                         imageUrl = card.imageUrl,
//                         rarity = card.rarity,
//                         collection = card.collection,
//                         description = card.description,
//                         disassemblePrice = card.disassemblePrice
//                     )
//                 }
//             )
//         }
//     }

//     fun getPackDetails(packId: Long): PackResponse {
//         val pack = packRepository.findById(packId)
//             .orElseThrow { EntityNotFoundException("Pack not found with id: $packId") }

//         return PackResponse(
//             id = pack.id,
//             name = pack.name,
//             imageUrl = pack.imageUrl,
//             price = pack.price,
//             cards = pack.cards.map { card: CardEntity ->
//                 CardResponse(
//                     id = card.id,
//                     name = card.name,
//                     imageUrl = card.imageUrl,
//                     rarity = card.rarity,
//                     collection = card.collection,
//                     description = card.description,
//                     type = card.type,
//                     disassemblePrice = card.disassemblePrice
//                 )
//             }
//         )
//     }

//     @Transactional
//     fun buyPack(packId: Long, user: UserEntity): PurchasePackResponse {
//         val pack = packRepository.findById(packId)
//             .orElseThrow { EntityNotFoundException("Pack not found with id: $packId") }

//         if (user.coins < pack.price) {
//             throw IllegalStateException("Insufficient funds")
//         }

//         // Update user's balance
//         val updatedUser = user.copy(coins = user.coins - pack.price)
//         userRepository.save(updatedUser)

//         // Add cards to user's inventory
//         val receivedCards = pack.cards.map { card: CardEntity ->
//             val userCard = card.copy(owner = updatedUser)
//             InventoryRepository.save(userCard)
//         }

//         return PurchasePackResponse(
//             receivedCards = receivedCards.map { card: CardEntity ->
//                 CardResponse(
//                     id = card.id,
//                     name = card.name,
//                     imageUrl = card.imageUrl,
//                     rarity = card.rarity,
//                     collection = card.collection,
//                     description = card.description,
//                     type = card.type,
//                     disassemblePrice = card.disassemblePrice
//                 )
//             },
//             newBalance = updatedUser.coins
//         )
//     }

//     fun getAllCoinOffers(): List<CoinOfferResponse> {
//         return coinOfferRepository.findAll().map { offer: CoinOfferEntity ->
//             CoinOfferResponse(
//                 id = offer.id,
//                 name = offer.name,
//                 coinsAmount = offer.coinsAmount,
//                 price = offer.price,
//                 imageUrl = offer.imageUrl,
//                 description = offer.description
//             )
//         }
//     }

//     fun getCoinOfferDetails(offerId: Long): CoinOfferResponse {
//         val offer = coinOfferRepository.findById(offerId)
//             .orElseThrow { EntityNotFoundException("Coin offer not found with id: $offerId") }

//         return CoinOfferResponse(
//             id = offer.id,
//             name = offer.name,
//             coinsAmount = offer.coinsAmount,
//             price = offer.price,
//             imageUrl = offer.imageUrl,
//             description = offer.description
//         )
//     }

//     fun purchaseCoins(offerId: Long, redirectUrl: String): PurchaseCoinsResponse {
//         coinOfferRepository.findById(offerId)
//             .orElseThrow { EntityNotFoundException("Coin offer not found with id: $offerId") }

//         // Here you would integrate with your payment gateway
//         // This is a simplified example
//         return PurchaseCoinsResponse(
//             paymentUrl = "$redirectUrl?offer_id=$offerId"
//         )
//     }

//     @Transactional
//     fun processPayment(request: PaymentCallbackRequest): Boolean {
//         if (request.status != "Успешно") {
//             return false
//         }

//         coinOfferRepository.findById(request.offerId)
//             .orElseThrow { EntityNotFoundException("Coin offer not found with id: ${request.offerId}") }

//         // Here you would validate the payment with your payment gateway
//         // and update the user's balance accordingly
//         return true
//     }
// } 