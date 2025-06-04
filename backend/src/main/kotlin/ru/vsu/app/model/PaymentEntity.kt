package ru.vsu.app.model

import com.fasterxml.jackson.annotation.JsonIgnore
import jakarta.persistence.*
import java.time.LocalDateTime

@Entity
@Table(name = "payments")
data class PaymentEntity(

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "payment_id")
    val paymentID: Int = 0,

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "user_id", nullable = false)
    @JsonIgnore
    val user: UserEntity,

    @Column(name = "payment_sum", nullable = false)
    val paymentSUM: Double,

    @Enumerated(EnumType.STRING)
    @Column(name = "payment_status", nullable = false)
    val paymentStatus: PaymentStatus,

    @Column(name = "payment_datetime", nullable = false)
    val paymentDateTime: LocalDateTime,

    // Эти данные сохраняются только при создании, поэтому можно не сохранять в БД или сохранять как JSON/строку
    @ElementCollection
    @CollectionTable(name = "payment_card_data", joinColumns = [JoinColumn(name = "payment_id")])
    @Column(name = "card_data")
    val bankCardData: List<String>? = null
) {

    enum class PaymentStatus(val value: String) {
        В_обработке("В обработке"),
        Оплачено("Оплачено"),
        Ошибка("Ошибка");

        override fun toString(): String = value
    }
}
