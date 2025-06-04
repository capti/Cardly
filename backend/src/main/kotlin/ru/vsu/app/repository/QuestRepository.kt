package ru.vsu.app.repository

import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository
import ru.vsu.app.model.QuestEntity

@Repository
interface QuestRepository : JpaRepository<QuestEntity, Int> {
    fun findByIsCompleted(isCompleted: Boolean): List<QuestEntity>
    fun findByIsClaimed(isClaimed: Boolean): List<QuestEntity>
}
