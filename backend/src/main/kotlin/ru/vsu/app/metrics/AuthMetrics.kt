package ru.vsu.app.metrics

import org.springframework.stereotype.Service

@Service
class AuthMetrics(private val metrics: MetricsRegistry) {

    // ===== Авторизация =====
    fun loginAttempt() {
        metrics.count("auth.login.attempt")
    }

    fun loginSuccess(userId: String) {
        metrics.count("auth.login.success", listOf(MetricTags.user(userId)))
    }

    fun loginFailure() {
        metrics.count("auth.login.failure")
    }

    fun loginDuration(duration: Long) {
        metrics.timer("auth.login.duration", duration)
    }

    // ===== Регистрация =====

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

    // ===== Верификация кода Email =====

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

    // ===== Переотправка кода на Email =====

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

    // ===== Сброс пароля через токен и код =====
    fun resetPasswordAttempt() {
        metrics.count("auth.reset.password.attempt")
    }

    
    fun resetPasswordDuration(durationMs: Long) {
        metrics.timer("auth.reset.password.duration", durationMs)
    }

    fun resetPasswordSuccess() {
        metrics.count("auth.reset.password.success")
    }

    fun resetPasswordValidationError() {
        metrics.count("reset.password.validation.error")
    }

    fun resetPasswordFailure() {
        metrics.count("reset.password.failure")
    }

    // ===== Обновление пароля после проверки =====
    fun passwordResetSuccess() {
        metrics.count("password.reset.success")
    }

    fun passwordResetFailure() {
        metrics.count("password.reset.failure")
    }

    fun passwordResetDuration(durationMs: Long) {
        metrics.timer("password.reset.duration", durationMs)
    }

    fun passwordResetAttempt() {
        metrics.count("password.reset.attempt")
    }

    // ===== Обновление токена (refresh) =====
    fun refreshSuccess() {
        metrics.count("auth.refresh.success")
    }

    fun refreshFailure() {
        metrics.count("auth.refresh.failure")
    }

    fun refreshDuration(durationMs: Long) {
        metrics.timer("auth.refresh.duration", durationMs)
    }

    fun refreshAttempt() {
        metrics.count("auth.refresh.attempt")
    }

    // ===== Проверка авторизации =====
    fun authCheckAttempt() {
        metrics.count("auth.check.attempt")
    }

    fun authCheckAuthorized() {
        metrics.count("auth.check.authorized")
    }

    fun authCheckUnauthorized() {
        metrics.count("auth.check.unauthorized")
    }

    fun authCheckDuration(durationMs: Long) {
        metrics.timer("auth.check.duration", durationMs)
    }

}
