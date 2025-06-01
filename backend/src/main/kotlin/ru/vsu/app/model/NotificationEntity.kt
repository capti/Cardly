package ru.vsu.app.model

import jakarta.persistence.*
import java.time.LocalDateTime

@Entity
@Table(name = "notifications")
data class NotificationEntity(

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "notification_ID")
    val notificationID: Int = 0,

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    val user: UserEntity,

    @Column(nullable = false)
    val message: String,

    @Column(nullable = false)
    val notificationDateTime: LocalDateTime,

    @ElementCollection
    @CollectionTable(name = "notification_links", joinColumns = [JoinColumn(name = "notification_ID")])
    @Column(name = "link")
    val links: List<String> = emptyList()
)
