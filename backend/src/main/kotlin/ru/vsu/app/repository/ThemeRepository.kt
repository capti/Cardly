package ru.vsu.app.repository

import org.springframework.data.jpa.repository.JpaRepository
import ru.vsu.app.model.ThemeEntity

interface ThemeRepository : JpaRepository<ThemeEntity, Long>
