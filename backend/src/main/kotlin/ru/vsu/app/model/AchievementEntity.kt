package ru.vsu.app.model

import jakarta.persistence.*
import java.util.*

@Entity
@Table(name = "achievements")
data class AchievementEntity(

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "achievement_id")
    val achievementID: Int = 0,

    @Column(name = "name", nullable = false)
    val name: String,

    @Column(name = "image_url", nullable = false)
    val imageURL: String,

    @Column(name = "description", nullable = false)
    val description: String,

    @Column(name = "is_unlocked", nullable = false)
    val isUnlocked: Boolean = false
)
