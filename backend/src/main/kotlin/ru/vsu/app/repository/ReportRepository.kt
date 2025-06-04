package ru.vsu.app.repository

import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository
import ru.vsu.app.model.ReportEntity

@Repository
interface ReportRepository : JpaRepository<ReportEntity, Long> {
    fun findByStatus(status: ReportEntity.Status): List<ReportEntity>
}
