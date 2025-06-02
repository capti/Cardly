package ru.vsu.app.model

import jakarta.persistence.*
import ru.vsu.app.model.UserEntity

@Entity
@Table(name = "cards")
data class CardEntity(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    val id: Int = 0,

    @Column(name = "name", nullable = false)
    val name: String,

    @Column(name = "image_url", nullable = false)
    val imageUrl: String,

    @Column(name = "rarity", nullable = false)
    @Enumerated(EnumType.STRING)
    val rarity: Rarity,

    @Column(name = "disassemble_price", nullable = false)
    val disassemblePrice: Int,

    @Column(name = "is_generated", nullable = false)
    val isGenerated: Boolean,

    @Column(name = "description")
    val description: String? = null,

    @Column(name = "theme")
    val theme: String? = null,

    @ManyToOne
    @JoinColumn(name = "collection_id")
    val collection: CollectionEntity? = null,

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "owner_id")
    val owner: UserEntity? = null,
) {
    enum class Rarity(val value: String) {
        Обычная("Обычная"),
        Редкая("Редкая"),
        Эпическая("Эпическая"),
        Легендарная("Легендарная"),
        Уникальная("Уникальная");

        companion object {
            fun forValue(value: String): Rarity =
                values().first { it.value == value }
        }
    }
}