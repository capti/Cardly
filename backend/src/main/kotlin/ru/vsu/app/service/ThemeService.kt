package ru.vsu.app.service

import org.springframework.stereotype.Service
import ru.vsu.app.model.ThemeEntity
import ru.vsu.app.repository.ThemeRepository
import ru.vsu.app.dto.ThemeDto

@Service
class ThemeService(private val themeRepository: ThemeRepository) {

    fun getAllThemes(): List<ThemeDto> {
        return themeRepository.findAll()
    }

    fun getThemeById(id: Long): ThemeDto? {
        return themeRepository.findById(id).orElse(null)
    }

    fun createTheme(theme: ThemeDto): ThemeDto {
        return try {
            themeRepository.save(theme)
        } catch (e: Exception) {
            throw RuntimeException("Failed to create theme", e)
        }
    }

    fun updateTheme(id: Long, theme: ThemeDto): ThemeDto {
        val existingTheme = themeRepository.findById(id).orElseThrow { Exception("Theme not found") }
        )
        return themeRepository.save(updatedTheme)
    }

    fun deleteTheme(id: Long) {
        themeRepository.deleteById(id)
    }
}
