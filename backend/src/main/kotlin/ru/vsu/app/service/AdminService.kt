package ru.vsu.app.service

import ru.vsu.app.dto.responses.admin.AdminStatsGet200Response
import org.springframework.stereotype.Service

@Service
class AdminService {
    fun getSystemStats(): AdminStatsGet200Response {
        // Implementation for getting system statistics
        return AdminStatsGet200Response()
    }
}
