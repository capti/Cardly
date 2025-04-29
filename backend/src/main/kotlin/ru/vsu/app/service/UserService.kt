package ru.vsu.app.service

import org.springframework.security.crypto.password.PasswordEncoder
import org.springframework.stereotype.Service
import ru.vsu.app.dto.*
import ru.vsu.app.model.User
import ru.vsu.app.repository.UserRepository
import kotlin.random.Random

@Service
class UserService(
    private val userRepository: UserRepository,
    private val passwordEncoder: PasswordEncoder,
    private val emailService: EmailService,
    private val jwtService: JwtService
) {

    fun register(request: RegisterRequest): RegisterResponse {
        // Проверяем, что пользователь с таким email или username еще не существует
        if (userRepository.existsByEmail(request.email)) {
            return RegisterResponse("Пользователь с таким email уже существует", false)
        }
        
        if (userRepository.existsByUsername(request.username)) {
            return RegisterResponse("Пользователь с таким username уже существует", false)
        }
        
        // Генерируем 6-значный код активации
        val activationCode = generateSixDigitCode()
        
        // Создаем пользователя
        val user = User(
            email = request.email,
            username = request.username,
            passwordHash = passwordEncoder.encode(request.password),
            isEnabled = false,
            activationToken = activationCode
        )
        
        userRepository.save(user)
        
        // Отправляем email с кодом подтверждения
        emailService.sendActivationEmail(user.email, activationCode)
        
        return RegisterResponse("Пользователь успешно зарегистрирован. Проверьте email для получения кода активации.", true)
    }
    
    fun activateAccount(request: ActivateAccountRequest): ApiResponse {
        val userOptional = userRepository.findByEmail(request.email)
        
        if (userOptional.isEmpty) {
            return ApiResponse("Пользователь с таким email не найден", false)
        }
        
        val user = userOptional.get()
        
        // Если аккаунт уже активирован
        if (user.isEnabled) {
            return ApiResponse("Аккаунт уже активирован", true)
        }
        
        // Проверяем код активации
        if (user.activationToken != request.code) {
            return ApiResponse("Неверный код активации", false)
        }
        
        // Обновляем пользователя
        val updatedUser = user.copy(
            isEnabled = true,
            activationToken = null
        )
        
        userRepository.save(updatedUser)
        
        return ApiResponse("Аккаунт успешно активирован", true)
    }
    
    fun login(request: LoginRequest): LoginResponse? {
        val userOptional = userRepository.findByEmail(request.email)
        
        if (userOptional.isEmpty) {
            return null
        }
        
        val user = userOptional.get()
        
        // Проверяем, активирован ли аккаунт
        if (!user.isEnabled) {
            return null
        }
        
        if (!passwordEncoder.matches(request.password, user.passwordHash)) {
            return null
        }
        
        val token = jwtService.generateToken(user.email)
        
        return LoginResponse(
            token = token,
            username = user.username,
            email = user.email
        )
    }
    
    fun getUserInfo(email: String): UserInfoResponse {
        val user = userRepository.findByEmail(email).orElseThrow { 
            IllegalArgumentException("Пользователь не найден") 
        }
        
        return UserInfoResponse(
            id = user.id,
            username = user.username,
            email = user.email
        )
    }
    
    fun forgotPassword(request: ForgotPasswordRequest): ApiResponse {
        val userOptional = userRepository.findByEmail(request.email)
        
        if (userOptional.isEmpty) {
            return ApiResponse("Пользователь с таким email не найден", false)
        }
        
        val user = userOptional.get()
        
        // Проверяем, активирован ли аккаунт
        if (!user.isEnabled) {
            return ApiResponse("Аккаунт не активирован", false)
        }
        
        // Генерируем 6-значный код для сброса пароля
        val resetCode = generateSixDigitCode()
        
        // Код будет действителен в течение 15 минут
        val expiryTime = System.currentTimeMillis() + (15 * 60 * 1000) // 15 минут
        
        // Обновляем пользователя с кодом сброса пароля
        val updatedUser = user.copy(
            passwordResetToken = resetCode,
            passwordResetTokenExpiry = expiryTime
        )
        
        userRepository.save(updatedUser)
        
        // Отправляем код сброса пароля по email
        emailService.sendPasswordResetEmail(user.email, resetCode)
        
        return ApiResponse("Код для сброса пароля отправлен на ваш email", true)
    }
    
    fun resetPassword(request: ResetPasswordRequest): ApiResponse {
        val userOptional = userRepository.findByPasswordResetToken(request.token)
        
        if (userOptional.isEmpty) {
            return ApiResponse("Неверный код сброса пароля", false)
        }
        
        val user = userOptional.get()
        
        // Сохраняем значение токена в локальную переменную
        val tokenExpiry = user.passwordResetTokenExpiry
        
        // Проверяем срок действия кода
        if (tokenExpiry == null || System.currentTimeMillis() > tokenExpiry) {
            return ApiResponse("Срок действия кода истек", false)
        }
        
        // Обновляем пользователя с новым паролем
        val updatedUser = user.copy(
            passwordHash = passwordEncoder.encode(request.newPassword),
            passwordResetToken = null,
            passwordResetTokenExpiry = null
        )
        
        userRepository.save(updatedUser)
        
        return ApiResponse("Пароль успешно изменен", true)
    }
    
    // Функция генерации 6-значного кода
    private fun generateSixDigitCode(): String {
        return (100000 + Random.nextInt(900000)).toString()
    }
} 