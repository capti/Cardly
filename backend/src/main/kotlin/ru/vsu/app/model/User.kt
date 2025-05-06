package ru.vsu.app.model

import jakarta.persistence.*

@Entity
@Table(name = "users")
data class User(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long = 0,
    
    @Column(unique = true, nullable = false)
    val email: String,
    
    @Column(unique = true, nullable = false)
    val username: String,
    
    @Column(nullable = false)
    val passwordHash: String,
    
    val isEnabled: Boolean = false,
    
    val activationToken: String? = null,
    
    val passwordResetToken: String? = null,
    
    val passwordResetTokenExpiry: Long? = null,
    
    @Column(nullable = false)
    var coins: Int = 1000
) 