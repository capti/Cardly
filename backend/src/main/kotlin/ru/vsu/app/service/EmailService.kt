package ru.vsu.app.service

import org.springframework.mail.SimpleMailMessage
import org.springframework.mail.javamail.JavaMailSender
import org.springframework.stereotype.Service
import org.springframework.beans.factory.annotation.Value

@Service
class EmailService(
    private val mailSender: JavaMailSender, 
    @Value("\${EMAIL_USERNAME}")
    private val fromEmail: String) {

    fun sendActivationEmail(to: String, code: String) {
        val message = SimpleMailMessage()
        message.setTo(to)
        message.setFrom(fromEmail)
        message.setSubject("Подтверждение регистрации")
        message.setText("""
            Спасибо за регистрацию! 
            
            Ваш код активации: $code
            
            Используйте этот код для активации вашего аккаунта.
            
            Если вы не регистрировались на нашем сайте, проигнорируйте это письмо.
        """.trimIndent())
        mailSender.send(message)
    }

    fun sendPasswordResetEmail(to: String, code: String) {
        val message = SimpleMailMessage()
        message.setTo(to)
        message.setFrom(fromEmail)
        message.setSubject("Сброс пароля")
        message.setText("""
            Вы запросили сброс пароля.
            
            Ваш код подтверждения: $code
            
            Используйте этот код для установки нового пароля.
            
            Если вы не запрашивали сброс пароля, проигнорируйте это письмо.
        """.trimIndent())
        mailSender.send(message)
    }
} 