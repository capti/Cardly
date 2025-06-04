package ru.vsu.app.service

import ru.vsu.app.dto.AchievementDto
import org.springframework.stereotype.Service

@Service
class AchievementService {
    fun deleteAchievement(achievementID: Int) {
        // Implementation for deleting an achievement
    }

    fun updateAchievement(achievementID: Int, achievement: AchievementDto): AchievementDto {
        // Implementation for updating an achievement
        return achievement
    }

    fun createAchievement(achievement: AchievementDto): AchievementDto {
        // Implementation for creating an achievement
        return achievement
    }
}
