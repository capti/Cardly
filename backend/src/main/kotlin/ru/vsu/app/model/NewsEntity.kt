package ru.vsu.app.model

import jakarta.persistence.*
import java.time.LocalDateTime

@Entity
data class NewsEntity(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Int? = null,

    var title: String,
    var content: String,
    val createdAt: LocalDateTime,
    var updatedAt: LocalDateTime
)
