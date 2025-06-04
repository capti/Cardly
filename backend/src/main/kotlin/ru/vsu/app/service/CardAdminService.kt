package ru.vsu.app.service

import ru.vsu.app.dto.CardDto

interface CardAdminService {
    fun createCard(card: CardDto): CardDto
    fun updateCard(cardID: Int, card: CardDto): CardDto
    fun deleteCard(cardID: Int)
} 