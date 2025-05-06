package ru.vsu.app.repository

import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository
import ru.vsu.app.model.Card
import ru.vsu.app.model.User

@Repository
interface CardRepository : JpaRepository<Card, Long> {
    fun findAllByOwner(user: User): List<Card>
    fun findAllByOwnerOrderByRarityDesc(user: User): List<Card>
    fun findAllByOwnerOrderByCollectionAsc(user: User): List<Card>
} 