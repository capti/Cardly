package ru.vsu.app.service

import ru.vsu.app.dto.TradeDto
import ru.vsu.app.dto.requests.AdminTradesTradeIDInvalidatePostRequest
import ru.vsu.app.dto.responses.admin.AdminTradesTradeIDInvalidatePost200Response
import ru.vsu.app.dto.requests.TradesInitiatePostRequest
import ru.vsu.app.model.TradeEntity
import ru.vsu.app.model.UserEntity
import ru.vsu.app.model.CardEntity
import ru.vsu.app.repository.TradeRepository
import ru.vsu.app.repository.UserRepository
import ru.vsu.app.repository.CardRepository
import ru.vsu.app.mapper.TradeMapper
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import org.springframework.http.HttpStatus
import org.springframework.web.server.ResponseStatusException
import java.time.LocalDateTime

@Service
class TradeService(
    private val tradeRepository: TradeRepository,
    private val userRepository: UserRepository,
    private val cardRepository: CardRepository,
    private val tradeMapper: TradeMapper
) {
    fun getAllTrades(search: String?): List<TradeDto> {
        val trades = if (search != null) {
            tradeRepository.findByOfferingCardsNameContainingOrReceivingCardsNameContaining(search, search)
        } else {
            tradeRepository.findAll()
        }
        return trades.map { tradeMapper.toDto(it) }
    }

    fun getTradeById(tradeId: Int): TradeDto {
        val trade = tradeRepository.findById(tradeId)
            .orElseThrow { ResponseStatusException(HttpStatus.NOT_FOUND, "Trade not found") }
        return tradeMapper.toDto(trade)
    }

    fun getUserTrades(userId: Int): List<TradeDto> {
        val user = userRepository.findById(userId)
            .orElseThrow { ResponseStatusException(HttpStatus.NOT_FOUND, "User not found") }
        val trades = tradeRepository.findByOfferingUserOrReceivingUser(user, user)
        return trades.map { tradeMapper.toDto(it) }
    }

    @Transactional
    fun initiateTrade(request: TradesInitiatePostRequest, currentUserId: Int): TradeDto {
        val offeringUser = userRepository.findById(currentUserId)
            .orElseThrow { ResponseStatusException(HttpStatus.NOT_FOUND, "Offering user not found") }
        
        val offeredCard = cardRepository.findById(request.offeredCardId)
            .orElseThrow { ResponseStatusException(HttpStatus.NOT_FOUND, "Offered card not found") }
            
        if (!offeringUser.inventoryCards.contains(offeredCard)) {
            throw ResponseStatusException(HttpStatus.BAD_REQUEST, "User doesn't own the offered card")
        }

        val requestedCards = request.requestedCardId.map { cardId ->
            cardRepository.findById(cardId)
                .orElseThrow { ResponseStatusException(HttpStatus.NOT_FOUND, "Requested card not found") }
        }

        val trade = TradeEntity(
            offeringUser = offeringUser,
            offeringCards = listOf(offeredCard),
            receivingUser = requestedCards.first().owner ?: throw ResponseStatusException(HttpStatus.BAD_REQUEST, "Requested card has no owner"),
            receivingCards = requestedCards,
            tradeDateTime = LocalDateTime.now()
        )

        val savedTrade = tradeRepository.save(trade)
        return tradeMapper.toDto(savedTrade)
    }

    @Transactional
    fun acceptTrade(tradeId: Int, currentUserId: Int): TradeDto {
        val trade = tradeRepository.findById(tradeId)
            .orElseThrow { ResponseStatusException(HttpStatus.NOT_FOUND, "Trade not found") }

        if (trade.receivingUser.userId != currentUserId) {
            throw ResponseStatusException(HttpStatus.FORBIDDEN, "User is not authorized to accept this trade")
        }

        if (trade.isConfirmed) {
            throw ResponseStatusException(HttpStatus.BAD_REQUEST, "Trade is already confirmed")
        }

        // Perform the card exchange
        val offeringUser = trade.offeringUser
        val receivingUser = trade.receivingUser
        
        offeringUser.inventoryCards = offeringUser.inventoryCards + trade.receivingCards
        receivingUser.inventoryCards = receivingUser.inventoryCards + trade.offeringCards
        offeringUser.inventoryCards = offeringUser.inventoryCards - trade.offeringCards
        receivingUser.inventoryCards = receivingUser.inventoryCards - trade.receivingCards

        val updatedTrade = trade.copy(isConfirmed = true)
        val savedTrade = tradeRepository.save(updatedTrade)
        return tradeMapper.toDto(savedTrade)
    }

    @Transactional
    fun rejectTrade(tradeId: Int, currentUserId: Int): TradeDto {
        val trade = tradeRepository.findById(tradeId)
            .orElseThrow { ResponseStatusException(HttpStatus.NOT_FOUND, "Trade not found") }

        if (trade.receivingUser.userId != currentUserId) {
            throw ResponseStatusException(HttpStatus.FORBIDDEN, "User is not authorized to reject this trade")
        }

        val updatedTrade = trade.copy(isConfirmed = false)
        val savedTrade = tradeRepository.save(updatedTrade)
        return tradeMapper.toDto(savedTrade)
    }

    @Transactional
    fun cancelTrade(tradeId: Int, currentUserId: Int): TradeDto {
        val trade = tradeRepository.findById(tradeId)
            .orElseThrow { ResponseStatusException(HttpStatus.NOT_FOUND, "Trade not found") }

        if (trade.offeringUser.userId != currentUserId) {
            throw ResponseStatusException(HttpStatus.FORBIDDEN, "User is not authorized to cancel this trade")
        }

        tradeRepository.delete(trade)
        return tradeMapper.toDto(trade)
    }

    @Transactional
    fun invalidateTrade(tradeId: Int, request: AdminTradesTradeIDInvalidatePostRequest): AdminTradesTradeIDInvalidatePost200Response {
        val trade = tradeRepository.findById(tradeId)
            .orElseThrow { ResponseStatusException(HttpStatus.NOT_FOUND, "Trade not found") }

        if (trade.isConfirmed) {
            // Reverse the trade
            val offeringUser = trade.offeringUser
            val receivingUser = trade.receivingUser
            
            offeringUser.inventoryCards = offeringUser.inventoryCards + trade.offeringCards
            receivingUser.inventoryCards = receivingUser.inventoryCards + trade.receivingCards
            offeringUser.inventoryCards = offeringUser.inventoryCards - trade.receivingCards
            receivingUser.inventoryCards = receivingUser.inventoryCards - trade.offeringCards
        }

        tradeRepository.delete(trade)
        return AdminTradesTradeIDInvalidatePost200Response()
    }
}
