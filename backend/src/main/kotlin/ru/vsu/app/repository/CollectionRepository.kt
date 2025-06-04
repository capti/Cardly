package ru.vsu.app.repository

import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository

import ru.vsu.app.model.CollectionEntity
import ru.vsu.app.model.UserEntity

@Repository
interface CollectionRepository : JpaRepository<CollectionEntity, Int> {
    fun findByNameContainingIgnoreCase(name: String): List<CollectionEntity>
}
