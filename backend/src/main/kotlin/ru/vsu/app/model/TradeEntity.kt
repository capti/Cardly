package ru.vsu.app.model

import jakarta.persistence.*
import java.time.LocalDateTime

@Entity
@Table(name = "trades")
data class TradeEntity(

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "trade_id")
    val tradeID: Int = 0,

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "offering_user_id", nullable = false)
    val offeringUser: UserEntity,

    @ManyToMany
    @JoinTable(
        name = "trade_offering_cards",
        joinColumns = [JoinColumn(name = "trade_id")],
        inverseJoinColumns = [JoinColumn(name = "card_id")]
    )
    val offeringCards: List<CardEntity> = emptyList(),

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "receiving_user_id", nullable = false)
    val receivingUser: UserEntity,

    @ManyToMany
    @JoinTable(
        name = "trade_receiving_cards",
        joinColumns = [JoinColumn(name = "trade_id")],
        inverseJoinColumns = [JoinColumn(name = "card_id")]
    )
    val receivingCards: List<CardEntity> = emptyList(),

    @Column(name = "is_confirmed", nullable = false)
    val isConfirmed: Boolean = false,

    @Column(name = "trade_date_time", nullable = false)
    val tradeDateTime: LocalDateTime
)
