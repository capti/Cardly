package ru.vsu.app.config

import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.mail.javamail.JavaMailSender
import org.springframework.mail.javamail.JavaMailSenderImpl
import java.util.Properties
import org.springframework.beans.factory.annotation.Value

@Configuration
class MailConfig {

    @Value("\${spring.mail.host}")
    private lateinit var host: String

    @Value("\${spring.mail.port}")
    private var port: Int = 0

    @Value("\${spring.mail.username}")
    private lateinit var username: String

    @Value("\${spring.mail.password}")
    private lateinit var password: String

    @Value("\${spring.mail.properties.mail.smtp.auth}")
    private lateinit var auth: String

    @Value("\${spring.mail.properties.mail.smtp.starttls.enable}")
    private lateinit var starttls: String

    @Value("\${spring.mail.properties.mail.transport.protocol:smtp}")
    private lateinit var protocol: String

    @Value("\${spring.mail.properties.mail.debug:false}")
    private lateinit var debug: String

    @Bean
    fun javaMailSender(): JavaMailSender {
        val mailSender = JavaMailSenderImpl()
        mailSender.host = host
        mailSender.port = port
        mailSender.username = username
        mailSender.password = password

        val props = mailSender.javaMailProperties
        props.put("mail.transport.protocol", protocol)
        props.put("mail.smtp.auth", auth)
        props.put("mail.smtp.starttls.enable", starttls)
        props.put("mail.debug", debug)

        return mailSender
    }
} 