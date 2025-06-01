package ru.vsu.app.config

import org.springframework.stereotype.Component

@Component
class PublicEndpointsConfig {
    val endpoints = listOf(
        "/api/auth/register",
        "/api/auth/login",
        "/api/auth/forgot-password",
        "/api/auth/reset-password",
        "/api/auth/activate",
        "/api/auth/resend-code",
        "/v3/api-docs/**",
        "/swagger-ui/**",
        "/swagger-ui.html",
        "/webjars/**",
        "/actuator/prometheus",
        "/error"
    )
    val passiveTokenEndpoints = listOf(
        "/api/auth/check"
    )
}
