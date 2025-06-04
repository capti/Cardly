package ru.vsu.app.service

import ru.vsu.app.dto.ReportDto
import ru.vsu.app.dto.requests.AdminReportsReportIDPutRequest
import org.springframework.stereotype.Service
import ru.vsu.app.dto.UserDto
import java.time.LocalDateTime

interface ReportService {
    fun getAllReports(): List<ReportDto>
    fun getReportById(reportID: Int): ReportDto?
    fun updateReportStatus(reportID: Int, request: AdminReportsReportIDPutRequest): ReportDto
}

@Service
class ReportServiceImpl : ReportService {
    fun getAllReports(): List<ReportDto> {
        // Implementation for getting all reports
        return emptyList()
    }

    fun getReportById(reportID: Int): ReportDto {
        // Implementation for getting a report by ID
        return ReportDto(
            reportID = reportID,
            reporter = UserDto(userID = 1, username = "Reporter", email = "reporter@example.com", inventoryCards = emptyList(), balance = 0, achievements = emptyList()),
            reportedUser = UserDto(userID = 2, username = "ReportedUser", email = "reporteduser@example.com", inventoryCards = emptyList(), balance = 0, achievements = emptyList()),
            reportDateTime = LocalDateTime.now(),
            reason = "Reason",
            status = ReportDto.Status.На_рассмотрении
        )
    }

    fun updateReportStatus(reportID: Int, request: AdminReportsReportIDPutRequest): ReportDto {
        // Implementation for updating report status
        return ReportDto(
            reportID = reportID,
            reporter = UserDto(userID = 1, username = "Reporter", email = "reporter@example.com", inventoryCards = emptyList(), balance = 0, achievements = emptyList()),
            reportedUser = UserDto(userID = 2, username = "ReportedUser", email = "reporteduser@example.com", inventoryCards = emptyList(), balance = 0, achievements = emptyList()),
            reportDateTime = LocalDateTime.now(),
            reason = "Reason",
            status = ReportDto.Status.Подтверждено
        )
    }
}
