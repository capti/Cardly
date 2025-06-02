package ru.vsu.app.mapper

import org.springframework.stereotype.Component
import ru.vsu.app.dto.CardDto
import ru.vsu.app.model.CardEntity

@Component
class CardMapper {
    fun toDto(entity: CardEntity): CardDto = CardDto(
        cardID = entity.id,
        name = entity.name,
        imageURL = entity.imageUrl,
        rarity = CardDto.Rarity.forValue(entity.rarity.value),
        minPrice = entity.disassemblePrice,
        isGenerated = entity.isGenerated,
        description = entity.description,
        theme = entity.theme
    )
}
