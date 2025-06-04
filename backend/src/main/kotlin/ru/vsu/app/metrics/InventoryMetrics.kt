package ru.vsu.app.metrics

import org.springframework.stereotype.Service

@Service
class InventoryMetrics(private val metrics: MetricsRegistry) {

    // ===== Получение инвентаря =====

    fun inventoryGetAttempt() {
        metrics.count("inventory.get.attempt")
    }

    fun inventoryGetSuccess() {
        metrics.count("inventory.get.success")
    }

    fun inventoryGetUnauthorized() {
        metrics.count("inventory.get.unauthorized") // 401
    }

    fun inventoryGetValidationError() {
        metrics.count("inventory.get.validation_error") // 400
    }

    fun inventoryGetFailure() {
        metrics.count("inventory.get.failure") // 500 или unexpected
    }

    fun inventoryGetDuration(durationMs: Long, userId: String? = null) {
        if (userId != null) {
            metrics.timer("inventory.get.duration", durationMs, listOf(MetricTags.user(userId)))
        } else {
            metrics.timer("inventory.get.duration", durationMs)
        }
    }

    // ===== Обновление/изменение инвентаря =====

    fun inventoryUpdateAttempt() {
        metrics.count("inventory.update.attempt")
    }

    fun inventoryUpdateSuccess(userId: String) {
        metrics.count("inventory.update.success", listOf(MetricTags.user(userId)))
    }

    fun inventoryUpdateValidationError() {
        metrics.count("inventory.update.validation_error")
    }

    fun inventoryUpdateFailure() {
        metrics.count("inventory.update.failure")
    }

    fun inventoryUpdateDuration(durationMs: Long, userId: String? = null) {
        if (userId != null) {
            metrics.timer("inventory.update.duration", durationMs, listOf(MetricTags.user(userId)))
        } else {
            metrics.timer("inventory.update.duration", durationMs)
        }
    }

    // ===== Удаление предмета из инвентаря =====

    fun inventoryDeleteAttempt() {
        metrics.count("inventory.delete.attempt")
    }

    fun inventoryDeleteSuccess(userId: String) {
        metrics.count("inventory.delete.success", listOf(MetricTags.user(userId)))
    }

    fun inventoryDeleteValidationError() {
        metrics.count("inventory.delete.validation_error")
    }

    fun inventoryDeleteFailure() {
        metrics.count("inventory.delete.failure")
    }

    fun inventoryDeleteDuration(durationMs: Long, userId: String? = null) {
        if (userId != null) {
            metrics.timer("inventory.delete.duration", durationMs, listOf(MetricTags.user(userId)))
        } else {
            metrics.timer("inventory.delete.duration", durationMs)
        }
    }
}
