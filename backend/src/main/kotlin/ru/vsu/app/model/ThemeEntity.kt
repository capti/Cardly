package ru.vsu.app.model

import jakarta.persistence.*

@Entity
@Table(name = "themes")
data class ThemeEntity(

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "theme_id")
    val themeID: Int = 0,

    @Column(name = "name", nullable = false)
    val name: String,

    @Column(name = "description")
    val description: String? = null
)
