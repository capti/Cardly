package ru.vsu.app.mapper

import ru.vsu.app.dto.TradeDto
import ru.vsu.app.model.TradeEntity
import org.springframework.stereotype.Component

@Component
class TradeMapper(
    private val userMapper: UserMapper,
    private val cardMapper: CardMapper
) {
    fun toDto(entity: TradeEntity): TradeDto {
        return TradeDto(
            tradeID = entity.tradeID,
            offeringUser = userMapper.toDto(entity.offeringUser),
            offeringCards = entity.offeringCards.map { cardMapper.toDto(it) },
            receivingUser = userMapper.toDto(entity.receivingUser),
            receivingCards = entity.receivingCards.map { cardMapper.toDto(it) },
            isConfirmed = entity.isConfirmed,
            tradeDateTime = entity.tradeDateTime
        )
    }
} 