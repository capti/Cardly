package ru.vsu.app.model

import jakarta.persistence.*

@Entity
@Table(name = "users")
data class UserEntity(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_id")
    val userId: Int = 0,

    @Column(unique = true, nullable = false)
    val email: String,

    @Column(unique = true, nullable = false)
    val username: String,

    @Column(nullable = false)
    val passwordHash: String,

    val isEnabled: Boolean = false,

    val activationToken: String? = null,

    val passwordResetToken: String? = null,

    val passwordResetTokenExpiry: Long? = null,

    @Column(nullable = false)
    var balance: Int = 1000,

    @Column(nullable = true, name = "avatar_url")
    var avatarUrl: String? = null,

    // Пример связи "один ко многим" — пользователь может иметь много карточек в инвентаре
    @OneToMany(targetEntity = CardEntity::class, fetch = FetchType.LAZY)
    @JoinTable(
        name = "user_inventory_cards",
        joinColumns = [JoinColumn(name = "user_id")],
        inverseJoinColumns = [JoinColumn(name = "card_id")]
    )
    var inventoryCards: List<CardEntity> = emptyList(),

    @OneToMany(targetEntity = CardEntity::class, fetch = FetchType.LAZY)
    @JoinTable(
        name = "user_favorite_cards",
        joinColumns = [JoinColumn(name = "user_id")],
        inverseJoinColumns = [JoinColumn(name = "card_id")]
    )
    var favoriteCards: List<CardEntity> = emptyList(),

    @OneToMany(targetEntity = CardEntity::class, fetch = FetchType.LAZY)
    @JoinTable(
        name = "user_onchange_cards",
        joinColumns = [JoinColumn(name = "user_id")],
        inverseJoinColumns = [JoinColumn(name = "card_id")]
    )
    var onChange: List<CardEntity> = emptyList(),

    @OneToMany(targetEntity = AchievementEntity::class, fetch = FetchType.LAZY)
    @JoinTable(
        name = "user_achievements",
        joinColumns = [JoinColumn(name = "user_id")],
        inverseJoinColumns = [JoinColumn(name = "achievement_id")]
    )
    var achievements: List<AchievementEntity> = emptyList(),

    @OneToMany(targetEntity = AchievementEntity::class, fetch = FetchType.LAZY)
    @JoinTable(
        name = "user_favorite_achievements",
        joinColumns = [JoinColumn(name = "user_id")],
        inverseJoinColumns = [JoinColumn(name = "achievement_id")]
    )
    var favoriteAchievements: List<AchievementEntity> = emptyList(),

    @OneToMany(targetEntity = NotificationEntity::class, fetch = FetchType.LAZY)
    @JoinTable(
        name = "user_notifications",
        joinColumns = [JoinColumn(name = "user_id")],
        inverseJoinColumns = [JoinColumn(name = "notification_id")]
    )
    var notifications: List<NotificationEntity> = emptyList()
)
