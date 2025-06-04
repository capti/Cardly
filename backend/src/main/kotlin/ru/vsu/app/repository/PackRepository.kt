package ru.vsu.app.repository

import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository
import ru.vsu.app.model.PackEntity

@Repository
interface PackRepository : JpaRepository<PackEntity, Long> 