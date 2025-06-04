package ru.vsu.app.service

import ru.vsu.app.dto.CardDto
import org.springframework.stereotype.Service

@Service
class CardService {
    fun deleteCard(cardID: Int) {
        // Implementation for deleting a card
    }

    fun updateCard(cardID: Int, card: CardDto): CardDto {
        // Implementation for updating a card
        return card
    }

    fun createCard(card: CardDto): CardDto {
        // Implementation for creating a card
        return card
    }
}
