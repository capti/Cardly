package ru.vsu.app.mapper

import org.springframework.stereotype.Component
import ru.vsu.app.dto.NotificationDto
import ru.vsu.app.model.NotificationEntity

@Component
class NotificationMapper {
    fun toDto(entity: NotificationEntity): NotificationDto = NotificationDto(
        notificationID = entity.notificationID,
        userID = entity.user.userId,
        message = entity.message,
        notificationDateTime = entity.notificationDateTime,
        links = entity.links.takeIf { it.isNotEmpty() }
    )
}
