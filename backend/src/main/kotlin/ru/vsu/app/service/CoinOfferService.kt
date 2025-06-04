package ru.vsu.app.service

import ru.vsu.app.dto.CoinOfferDto
import org.springframework.stereotype.Service

@Service
class CoinOfferService {
    fun getAllCoinOffers(): List<CoinOfferDto> {
        // Implementation for getting all coin offers
        return emptyList()
    }

    fun deleteCoinOffer(offerId: Int) {
        // Implementation for deleting a coin offer
    }

    fun updateCoinOffer(offerId: Int, coinOffer: CoinOfferDto): CoinOfferDto {
        // Implementation for updating a coin offer
        return coinOffer
    }

    fun createCoinOffer(coinOffer: CoinOfferDto): CoinOfferDto {
        // Implementation for creating a coin offer
        return coinOffer
    }
}
