package ru.vsu.app.service

import io.jsonwebtoken.Claims
import io.jsonwebtoken.Jwts
import io.jsonwebtoken.SignatureAlgorithm
import io.jsonwebtoken.io.Decoders
import io.jsonwebtoken.ExpiredJwtException
import io.jsonwebtoken.security.Keys
import org.springframework.beans.factory.annotation.Value
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.stereotype.Service
import java.security.Key
import java.util.*

@Service
class JwtService {
    
    @Value("\${application.security.jwt.secret-key}")
    private lateinit var secretKey: String
    
    @Value("\${application.security.jwt.expiration}")
    private var jwtExpiration: Long = 0

    fun extractUsername(token: String): String {
        return extractClaim(token) { obj: Claims -> obj.subject }
    }

    fun extractUsernameIgnoreExpiration(token: String): String? {
        return try {
            extractClaim(token) { it.subject }
        } catch (ex: ExpiredJwtException) {
            ex.claims.subject // достаём email из протухшего токена
        } catch (ex: Exception) {
            null
        }
    }

    fun <T> extractClaim(token: String, claimsResolver: (Claims) -> T): T {
        val claims = extractAllClaims(token)
        return claimsResolver(claims)
    }

    fun generateToken(userEmail: String): String {
        return generateToken(HashMap(), userEmail)
    }

    fun generateToken(extraClaims: Map<String, Any>, userEmail: String): String {
        return Jwts
            .builder()
            .setClaims(extraClaims)
            .setSubject(userEmail)
            .setIssuedAt(Date(System.currentTimeMillis()))
            .setExpiration(Date(System.currentTimeMillis() + jwtExpiration))
            .signWith(getSigningKey(), SignatureAlgorithm.HS256)
            .compact()
    }

    fun isTokenValid(token: String, userDetails: UserDetails): Boolean {
        val username = extractUsername(token)
        return username == userDetails.username && !isTokenExpired(token)
    }

    fun isTokenExpired(token: String): Boolean {
        return extractExpiration(token).before(Date())
    }

    private fun extractExpiration(token: String): Date {
        return extractClaim(token) { it.expiration }
    }

    private fun extractAllClaims(token: String): Claims {
        return Jwts
            .parserBuilder()
            .setSigningKey(getSigningKey())
            .build()
            .parseClaimsJws(token)
            .body
    }

    fun generatePasswordResetToken(email: String, code: String): String {
        val now = Date()
        val expiration = Date(now.time + 24 * 60 * 60 * 1000) // 24 часа

        return Jwts.builder()
            .setSubject(email)
            .claim("code", code)
            .setIssuedAt(now)
            .setExpiration(expiration)
            .signWith(SignatureAlgorithm.HS256, secretKey)
            .compact()
    }

    fun parseResetToken(token: String): ResetTokenPayload {
        val claims = Jwts.parserBuilder()
            .setSigningKey(secretKey)
            .build()
            .parseClaimsJws(token)
            .body

        return ResetTokenPayload(
            email = claims.subject,
            code = claims["code"] as String
        )
    }


    private fun getSigningKey(): Key {
        val keyBytes = Decoders.BASE64.decode(secretKey)
        return Keys.hmacShaKeyFor(keyBytes)
    }
} 

data class ResetTokenPayload(
    val email: String,
    val code: String
)