package ru.vsu.app.repository

import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository
import ru.vsu.app.model.CardEntity
import ru.vsu.app.model.UserEntity

@Repository
interface CardRepository : JpaRepository<CardEntity, Long> {
    fun findById(id: Int): CardEntity?
    fun findAllByOwner(user: UserEntity): List<CardEntity>
    fun findAllByOwnerOrderByRarityDesc(user: UserEntity): List<CardEntity>
    fun findAllByOwnerOrderByCollectionAsc(user: UserEntity): List<CardEntity>
} 