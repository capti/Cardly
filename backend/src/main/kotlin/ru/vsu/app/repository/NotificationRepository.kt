package ru.vsu.app.repository

import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository
import ru.vsu.app.model.NotificationEntity

@Repository
interface NotificationRepository : JpaRepository<NotificationEntity, Int> {
    fun findByUserUserId(userId: Int): List<NotificationEntity>
}
