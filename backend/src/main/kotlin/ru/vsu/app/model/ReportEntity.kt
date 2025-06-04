package ru.vsu.app.model

import jakarta.persistence.*
import java.time.LocalDateTime

@Entity
@Table(name = "reports")
data class ReportEntity(

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long = 0,

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "reporter_id", nullable = false)
    val reporter: UserEntity,

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "reported_user_id", nullable = false)
    val reportedUser: UserEntity,

    @Column(nullable = false)
    val reportDateTime: LocalDateTime,

    @Column(nullable = false)
    val reason: String,

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    val status: Status
) {
    enum class Status {
        На_рассмотрении,
        Подтверждено,
        Отклонено
    }
}
