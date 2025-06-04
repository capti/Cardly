package ru.vsu.app.mapper

import org.springframework.stereotype.Component
import ru.vsu.app.dto.*
import ru.vsu.app.model.*

@Component
class UserMapper(
    private val cardMapper: CardMapper,
    private val achievementMapper: AchievementMapper,
    private val notificationMapper: NotificationMapper
) {
    fun toDto(entity: UserEntity): UserDto {
        return UserDto(
            userID = entity.userId,
            username = entity.username,
            email = entity.email,
            inventoryCards = entity.inventoryCards.map { cardMapper.toDto(it) },
            balance = entity.balance,
            achievements = entity.achievements.map { achievementMapper.toDto(it) },
            favoriteCards = if (entity.favoriteCards.isEmpty()) null else entity.favoriteCards.map { cardMapper.toDto(it) },
            onChange = if (entity.onChange.isEmpty()) null else entity.onChange.map { cardMapper.toDto(it) },
            avatarUrl = entity.avatarUrl,
            favoriteAchievements = if (entity.favoriteAchievements.isEmpty()) null else entity.favoriteAchievements.map { achievementMapper.toDto(it) },
            notifications = if (entity.notifications.isEmpty()) null else entity.notifications.map { notificationMapper.toDto(it) }
        )
    }
}
