package ru.vsu.app.model

import jakarta.persistence.*

@Entity
@Table(name = "collections")
data class CollectionEntity(

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "collection_id")
    val collectionID: Int = 0,

    @Column(nullable = false)
    val name: String,

    @OneToMany(mappedBy = "collection", cascade = [CascadeType.ALL], fetch = FetchType.LAZY, orphanRemoval = true)
    val cards: List<CardEntity> = emptyList(),

    @Column(name = "image_url", nullable = false)
    val imageURL: String
)
