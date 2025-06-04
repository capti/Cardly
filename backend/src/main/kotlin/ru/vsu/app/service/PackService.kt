package ru.vsu.app.service

import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import ru.vsu.app.dto.PackDto
import ru.vsu.app.dto.CardDto
import ru.vsu.app.model.PackEntity
import ru.vsu.app.model.CardEntity
import ru.vsu.app.repository.PackRepository
import jakarta.persistence.EntityNotFoundException

@Service
class PackService(
    private val packRepository: PackRepository
) {
    @Transactional
    fun createPack(pack: PackDto): PackDto {
        val packEntity = PackEntity(
            name = pack.name,
            imageUrl = pack.imageURL,
            price = pack.price,
            cards = pack.cards.map { cardDto ->
                CardEntity(
                    name = cardDto.name,
                    imageUrl = cardDto.imageURL,
                    rarity = CardEntity.Rarity.Обычная, // Default value
                    disassemblePrice = 0, // Default value
                    isGenerated = false // Default value
                )
            }.toList()
        )
        
        val savedPack = packRepository.save(packEntity)
        
        return PackDto(
            packID = savedPack.id.toInt(),
            name = savedPack.name,
            imageURL = savedPack.imageUrl,
            cards = savedPack.cards.map { cardEntity ->
                CardDto(
                    cardID = cardEntity.id,
                    name = cardEntity.name,
                    imageURL = cardEntity.imageUrl,
                    rarity = CardDto.Rarity.Обычная,
                    minPrice = cardEntity.disassemblePrice,
                    isGenerated = cardEntity.isGenerated,
                    description = cardEntity.description,
                    theme = null
                )
            }.toList(),
            price = savedPack.price
        )
    }

    @Transactional
    fun updatePack(packID: Int, pack: PackDto): PackDto {
        val existingPack = packRepository.findById(packID.toLong())
            .orElseThrow { EntityNotFoundException("Pack not found with id: $packID") }

        val updatedPack = existingPack.copy(
            name = pack.name,
            imageUrl = pack.imageURL,
            price = pack.price,
            cards = pack.cards.map { cardDto ->
                CardEntity(
                    name = cardDto.name,
                    imageUrl = cardDto.imageURL,
                    rarity = CardEntity.Rarity.Обычная, // Default value
                    disassemblePrice = 0, // Default value
                    isGenerated = false // Default value
                )
            }.toList()
        )

        val savedPack = packRepository.save(updatedPack)

        return PackDto(
            packID = savedPack.id.toInt(),
            name = savedPack.name,
            imageURL = savedPack.imageUrl,
            cards = savedPack.cards.map { cardEntity ->
                CardDto(
                    cardID = cardEntity.id,
                    name = cardEntity.name,
                    imageURL = cardEntity.imageUrl,
                    rarity = CardDto.Rarity.Обычная,
                    minPrice = cardEntity.disassemblePrice,
                    isGenerated = cardEntity.isGenerated,
                    description = cardEntity.description,
                    theme = null
                )
            }.toList(),
            price = savedPack.price
        )
    }

    @Transactional
    fun deletePack(packID: Int) {
        if (!packRepository.existsById(packID.toLong())) {
            throw EntityNotFoundException("Pack not found with id: $packID")
        }
        packRepository.deleteById(packID.toLong())
    }
}
