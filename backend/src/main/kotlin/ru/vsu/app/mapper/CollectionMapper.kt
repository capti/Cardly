package ru.vsu.app.mapper

import org.springframework.stereotype.Component
import ru.vsu.app.dto.CollectionDto
import ru.vsu.app.model.CollectionEntity
import ru.vsu.app.mapper.CardMapper

@Component
class CollectionMapper(
    private val cardMapper: CardMapper
) {
    fun toDto(entity: CollectionEntity): CollectionDto {
        return CollectionDto(
            collectionID = entity.collectionID,
            name = entity.name,
            cards = entity.cards.map { cardMapper.toDto(it) },
            imageURL = entity.imageURL
        )
    }
}
