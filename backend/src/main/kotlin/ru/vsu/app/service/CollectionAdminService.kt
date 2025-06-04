package ru.vsu.app.service

import ru.vsu.app.dto.CollectionDto

interface CollectionAdminService {
    fun createCollection(collection: CollectionDto): CollectionDto
    fun updateCollection(collectionID: Int, collection: CollectionDto): CollectionDto
    fun deleteCollection(collectionID: Int)
} 