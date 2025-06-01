package ru.vsu.app.mapper

import org.springframework.stereotype.Component
import ru.vsu.app.dto.AchievementDto
import ru.vsu.app.model.AchievementEntity

@Component
class AchievementMapper {
    fun toDto(entity: AchievementEntity): AchievementDto = AchievementDto(
        achievementID = entity.achievementID,
        name = entity.name,
        imageURL = entity.imageURL,
        description = entity.description,
        isUnlocked = entity.isUnlocked
    )
}
