package ru.vsu.app.model

import jakarta.persistence.*

@Entity
@Table(name = "user_stats")
data class UserStatsEntity(

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long = 0,

    @Column(nullable = false)
    val totalCards: Int = 0,

    @Column(nullable = false)
    val completedCollections: Int = 0,

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false, unique = true)
    val user: UserEntity
)
