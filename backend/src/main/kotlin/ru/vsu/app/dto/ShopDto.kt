package ru.vsu.app.dto

data class PackResponse(
    val id: Long,
    val name: String,
    val imageUrl: String,
    val price: Int,
    val cards: List<CardResponse>
)

data class CoinOfferResponse(
    val id: Long,
    val name: String,
    val coinsAmount: Int,
    val price: Double,
    val imageUrl: String,
    val description: String?
)

data class PurchasePackResponse(
    val receivedCards: List<CardResponse>,
    val newBalance: Int
)

data class PurchaseCoinsResponse(
    val paymentUrl: String
)

data class PaymentCallbackRequest(
    val transactionId: String,
    val status: String,
    val amount: Double,
    val currency: String,
    val offerId: Long
) 