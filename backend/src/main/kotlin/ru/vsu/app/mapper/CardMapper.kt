package ru.vsu.app.mapper

import org.springframework.stereotype.Component
import ru.vsu.app.dto.CardDto
import ru.vsu.app.model.CardEntity
import ru.vsu.app.mapper.ThemeMapper

@Component
class CardMapper(
    private val themeMapper: ThemeMapper
) {
    fun toDto(cardEntity: CardEntity): CardDto {
        return CardDto(
            cardID = cardEntity.id,
            name = cardEntity.name,
            description = cardEntity.description,
            rarity = CardDto.Rarity.forValue(cardEntity.rarity.value),
            imageURL = cardEntity.imageUrl,
            minPrice = cardEntity.disassemblePrice,
            isGenerated = cardEntity.isGenerated,
            theme = cardEntity.theme?.let { themeMapper.toDto(it) }
        )
    }
}
