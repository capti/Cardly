package ru.vsu.app.repository

import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository
import ru.vsu.app.model.UserStatsEntity
import ru.vsu.app.model.UserEntity

@Repository
interface UserStatsRepository : JpaRepository<UserStatsEntity, Long> {
    fun findByUser(user: UserEntity): UserStatsEntity?
}
