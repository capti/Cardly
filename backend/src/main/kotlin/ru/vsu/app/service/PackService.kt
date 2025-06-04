package ru.vsu.app.service

import ru.vsu.app.dto.PackDto

interface PackService {
    fun createPack(pack: PackDto): PackDto
    fun updatePack(packID: Int, pack: PackDto): PackDto
    fun deletePack(packID: Int)
}
