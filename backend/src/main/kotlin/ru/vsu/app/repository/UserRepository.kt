package ru.vsu.app.repository

import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.query.Param
import ru.vsu.app.model.UserEntity
import java.util.Optional

@Repository
interface UserRepository : JpaRepository<UserEntity, Long> {
    fun findByEmail(email: String): Optional<UserEntity>
    fun findByUsername(username: String): Optional<UserEntity>
    fun findByActivationToken(activationToken: String): Optional<UserEntity>
    fun findByPasswordResetToken(passwordResetToken: String): Optional<UserEntity>
    fun existsByEmail(email: String): Boolean
    fun existsByUsername(username: String): Boolean

    @Query("""
    SELECT u FROM UserEntity u
    LEFT JOIN FETCH u.inventoryCards
    LEFT JOIN FETCH u.favoriteCards
    LEFT JOIN FETCH u.onChange
    LEFT JOIN FETCH u.achievements
    LEFT JOIN FETCH u.favoriteAchievements
    LEFT JOIN FETCH u.notifications
    WHERE u.userId = :userId
    """)
    fun findByIdWithRelations(@Param("userId") userId: Int): UserEntity?

} 