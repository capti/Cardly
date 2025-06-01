package ru.vsu.app.metrics

import org.springframework.stereotype.Service

@Service
class AuthMetrics(private val metrics: MetricsRegistry) {

    fun loginAttempt() {
        metrics.count("auth.login.attempt")
    }

    fun loginSuccess(userId: String) {
        metrics.count("auth.login.success", listOf(MetricTags.user(userId)))
    }

    fun loginFailure() {
        metrics.count("auth.login.failure")
    }

    fun loginDuration(duration: Long, userId: String) {
        metrics.timer("auth.login.duration", duration, listOf(MetricTags.user(userId)))
    }

    fun registerAttempt() {
        metrics.count("auth.register.attempt")
    }

    fun registerSuccess() {
        metrics.count("auth.register.success")
    }

    fun registerConflict() {
        metrics.count("auth.register.conflict") // 409
    }

    fun registerValidationError() {
        metrics.count("auth.register.validation_error") // 400
    }

    fun registerFailure() {
        metrics.count("auth.register.failure") // 500 или default
    }

    fun registerDuration(durationMs: Long) {
        metrics.timer("auth.register.duration", durationMs)
    }

    fun verifyAttempt() {
        metrics.count("auth.verify.attempt")
    }

    fun verifySuccess(userId: String) {
        metrics.count("auth.verify.success", listOf(MetricTags.user(userId)))
    }

    fun verifyValidationError() {
        metrics.count("auth.verify.validation_error") // 400
    }

    fun verifyExpired() {
        metrics.count("auth.verify.expired") // 410
    }

    fun verifyFailure() {
        metrics.count("auth.verify.failure") // 500 или default
    }

    fun verifyDuration(durationMs: Long, userId: String? = null) {
        if (userId != null) {
            metrics.timer("auth.verify.duration", durationMs, listOf(MetricTags.user(userId)))
        } else {
            metrics.timer("auth.verify.duration", durationMs)
        }
    }

    fun resendVerificationCodeAttempt() {
        metrics.count("auth.resend_code.attempt")
    }

    fun resendVerificationCodeSuccess() {
        metrics.count("auth.resend_code.success")
    }

    fun resendVerificationCodeValidationError() {
        metrics.count("auth.resend_code.validation_error") // 400
    }

    fun resendVerificationCodeFailure() {
        metrics.count("auth.resend_code.failure") // 500 или default
    }

    fun resendVerificationCodeDuration(durationMs: Long) {
        metrics.timer("auth.resend_code.duration", durationMs)
    }

}
