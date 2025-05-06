package ru.vsu.app.dto

data class CardResponse(
    val id: Long,
    val name: String,
    val imageUrl: String,
    val rarity: Int,
    val collection: String,
    val description: String,
    val type: String,
    val disassemblePrice: Int
) 