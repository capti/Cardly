package ru.vsu.app.service

import ru.vsu.app.dto.CollectionDto
import org.springframework.stereotype.Service

@Service
class CollectionService {
    fun deleteCollection(collectionID: Int) {
        // Implementation for deleting a collection
    }

    fun updateCollection(collectionID: Int, collection: CollectionDto): CollectionDto {
        // Implementation for updating a collection
        return collection
    }

    fun createCollection(collection: CollectionDto): CollectionDto {
        // Implementation for creating a collection
        return collection
    }
}
