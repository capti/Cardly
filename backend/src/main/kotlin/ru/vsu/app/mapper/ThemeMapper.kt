package ru.vsu.app.mapper

import org.springframework.stereotype.Component
import ru.vsu.app.dto.ThemeDto
import ru.vsu.app.model.ThemeEntity

@Component
class ThemeMapper {

    fun toDto(entity: ThemeEntity): ThemeDto {
        return ThemeDto(
            themeID = entity.themeID,
            name = entity.name,
            description = entity.description
        )
        
    fun toEntity(dto: ThemeDto): ThemeEntity {
        return ThemeEntity(
            themeID = dto.themeID,
            name = dto.name,
            description = dto.description
        )
    }
}
}
