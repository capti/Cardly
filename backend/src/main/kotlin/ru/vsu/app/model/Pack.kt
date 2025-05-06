package ru.vsu.app.model

import jakarta.persistence.*

@Entity
@Table(name = "packs")
data class Pack(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long = 0,

    @Column(nullable = false)
    val name: String,

    @Column(nullable = false)
    val imageUrl: String,

    @Column(nullable = false)
    val price: Int,

    @ManyToMany
    @JoinTable(
        name = "pack_cards",
        joinColumns = [JoinColumn(name = "pack_id")],
        inverseJoinColumns = [JoinColumn(name = "card_id")]
    )
    val cards: List<Card> = emptyList()
) 