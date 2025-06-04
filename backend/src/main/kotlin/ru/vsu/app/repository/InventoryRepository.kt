package ru.vsu.app.repository

import org.springframework.data.jpa.repository.JpaRepository
import ru.vsu.app.model.CardEntity
import ru.vsu.app.model.UserEntity

interface InventoryRepository : JpaRepository<CardEntity, Int> {
}
