package ru.vsu.app.model

import jakarta.persistence.*

@Entity
@Table(name = "coin_offers")
data class CoinOffer(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long = 0,

    @Column(nullable = false)
    val name: String,

    @Column(nullable = false)
    val coinsAmount: Int,

    @Column(nullable = false)
    val price: Double,

    @Column(nullable = false)
    val imageUrl: String,

    @Column(length = 1000)
    val description: String?
) 