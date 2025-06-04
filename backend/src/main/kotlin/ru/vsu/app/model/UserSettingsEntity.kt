package ru.vsu.app.model

import jakarta.persistence.*

@Entity
@Table(name = "user_settings")
data class UserSettingsEntity(

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "settings_id")
    val id: Int = 0,

    @Column(name = "notifications_enabled", nullable = false)
    val notificationsEnabled: Boolean = true,

    @Column(name = "show_inventory", nullable = false)
    val showInventory: Boolean = false,

    @Column(name = "auto_decline_trades", nullable = false)
    val autoDeclineTrades: Boolean = false,

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", unique = true, nullable = false)
    val user: UserEntity
)
