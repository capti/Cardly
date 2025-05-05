package ru.vsu.app.model

import jakarta.persistence.*

@Entity
@Table(name = "cards")
data class Card(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long = 0,

    @Column(nullable = false)
    val name: String,

    @Column(nullable = false)
    val imageUrl: String,

    @Column(nullable = false)
    val rarity: Int,

    @Column(nullable = false)
    val collection: String,

    @Column(nullable = false, length = 1000)
    val description: String,

    @Column(nullable = false)
    val type: String,

    @Column(nullable = false)
    val disassemblePrice: Int = 150,

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    val owner: User? = null
) 