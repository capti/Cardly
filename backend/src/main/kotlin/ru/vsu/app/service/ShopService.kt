package ru.vsu.app.service

import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import ru.vsu.app.dto.*
import ru.vsu.app.model.User
import ru.vsu.app.repository.PackRepository
import ru.vsu.app.repository.CoinOfferRepository
import ru.vsu.app.repository.UserRepository
import ru.vsu.app.repository.CardRepository
import jakarta.persistence.EntityNotFoundException

@Service
class ShopService(
    private val packRepository: PackRepository,
    private val coinOfferRepository: CoinOfferRepository,
    private val userRepository: UserRepository,
    private val cardRepository: CardRepository
) {
    fun getAllPacks(): List<PackResponse> {
        return packRepository.findAll().map { pack ->
            PackResponse(
                id = pack.id,
                name = pack.name,
                imageUrl = pack.imageUrl,
                price = pack.price,
                cards = pack.cards.map { card ->
                    CardResponse(
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
            )
        }
    }

    fun getPackDetails(packId: Long): PackResponse {
        val pack = packRepository.findById(packId)
            .orElseThrow { EntityNotFoundException("Pack not found with id: $packId") }

        return PackResponse(
            id = pack.id,
            name = pack.name,
            imageUrl = pack.imageUrl,
            price = pack.price,
            cards = pack.cards.map { card ->
                CardResponse(
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
        )
    }

    @Transactional
    fun buyPack(packId: Long, user: User): PurchasePackResponse {
        val pack = packRepository.findById(packId)
            .orElseThrow { EntityNotFoundException("Pack not found with id: $packId") }

        if (user.coins < pack.price) {
            throw IllegalStateException("Insufficient funds")
        }

        // Update user's balance
        val updatedUser = user.copy(coins = user.coins - pack.price)
        userRepository.save(updatedUser)

        // Add cards to user's inventory
        val receivedCards = pack.cards.map { card ->
            val userCard = card.copy(owner = updatedUser)
            cardRepository.save(userCard)
        }

        return PurchasePackResponse(
            receivedCards = receivedCards.map { card ->
                CardResponse(
                    id = card.id,
                    name = card.name,
                    imageUrl = card.imageUrl,
                    rarity = card.rarity,
                    collection = card.collection,
                    description = card.description,
                    type = card.type,
                    disassemblePrice = card.disassemblePrice
                )
            },
            newBalance = updatedUser.coins
        )
    }

    fun getAllCoinOffers(): List<CoinOfferResponse> {
        return coinOfferRepository.findAll().map { offer ->
            CoinOfferResponse(
                id = offer.id,
                name = offer.name,
                coinsAmount = offer.coinsAmount,
                price = offer.price,
                imageUrl = offer.imageUrl,
                description = offer.description
            )
        }
    }

    fun getCoinOfferDetails(offerId: Long): CoinOfferResponse {
        val offer = coinOfferRepository.findById(offerId)
            .orElseThrow { EntityNotFoundException("Coin offer not found with id: $offerId") }

        return CoinOfferResponse(
            id = offer.id,
            name = offer.name,
            coinsAmount = offer.coinsAmount,
            price = offer.price,
            imageUrl = offer.imageUrl,
            description = offer.description
        )
    }

    fun purchaseCoins(offerId: Long, redirectUrl: String): PurchaseCoinsResponse {
        val offer = coinOfferRepository.findById(offerId)
            .orElseThrow { EntityNotFoundException("Coin offer not found with id: $offerId") }

        // Here you would integrate with your payment gateway
        // This is a simplified example
        return PurchaseCoinsResponse(
            paymentUrl = "$redirectUrl?offer_id=$offerId"
        )
    }

    @Transactional
    fun processPayment(request: PaymentCallbackRequest): Boolean {
        if (request.status != "Успешно") {
            return false
        }

        val offer = coinOfferRepository.findById(request.offerId)
            .orElseThrow { EntityNotFoundException("Coin offer not found with id: ${request.offerId}") }

        // Here you would validate the payment with your payment gateway
        // and update the user's balance accordingly
        return true
    }
} 