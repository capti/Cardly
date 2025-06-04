package ru.vsu.app.repository

import ru.vsu.app.model.TradeEntity
import ru.vsu.app.model.UserEntity
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository

@Repository
interface TradeRepository : JpaRepository<TradeEntity, Int> {
    fun findByOfferingUserOrReceivingUser(offeringUser: UserEntity, receivingUser: UserEntity): List<TradeEntity>
    fun findByOfferingCardsNameContainingOrReceivingCardsNameContaining(offeringCardName: String, receivingCardName: String): List<TradeEntity>
} 