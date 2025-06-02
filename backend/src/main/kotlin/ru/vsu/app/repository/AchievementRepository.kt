package ru.vsu.app.repository

import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository
import ru.vsu.app.model.AchievementEntity

@Repository
interface AchievementRepository : JpaRepository<AchievementEntity, Int> {
    fun findByIsUnlocked(isUnlocked: Boolean): List<AchievementEntity>
}
