package ru.vsu.app.config

import io.swagger.v3.oas.models.Components
import io.swagger.v3.oas.models.OpenAPI
import io.swagger.v3.oas.models.info.Contact
import io.swagger.v3.oas.models.info.Info
import io.swagger.v3.oas.models.security.SecurityRequirement
import io.swagger.v3.oas.models.security.SecurityScheme
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration

@Configuration
class OpenApiConfig {

    @Bean
    fun openAPI(): OpenAPI {
        return OpenAPI()
            .info(getApiInfo())
            .addSecurityItem(SecurityRequirement().addList("Bearer Authentication"))
            .components(
                Components()
                    .addSecuritySchemes(
                        "Bearer Authentication",
                        SecurityScheme()
                            .type(SecurityScheme.Type.HTTP)
                            .scheme("bearer")
                            .bearerFormat("JWT")
                            .description("Введите JWT токен в формате: Bearer {token}")
                    )
            )
    }

    private fun getApiInfo(): Info {
        return Info()
            .title("REST API Cardly")
            .description("API для взаимодействия с приложением Cardly")
            .version("1.0")
            .contact(
                Contact()
                    .name("Anna Dobrova")
                    .email("anyaadobrova@gmail.com")
            )
    }
} 