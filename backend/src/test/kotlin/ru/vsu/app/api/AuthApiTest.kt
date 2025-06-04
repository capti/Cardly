package org.openapitools.api

import org.openapitools.model.AuthCheckGet401Response
import org.openapitools.model.LoginUser400Response
import org.openapitools.model.LoginUser401Response
import org.openapitools.model.LoginUserRequest
import org.openapitools.model.RegisterUser200Response
import org.openapitools.model.RegisterUser400Response
import org.openapitools.model.RegisterUser409Response
import org.openapitools.model.InternalServerError
import org.openapitools.model.RegisterUserRequest
import org.openapitools.model.RequestPasswordReset200Response
import org.openapitools.model.RequestPasswordReset400Response
import org.openapitools.model.RequestPasswordReset404Response
import org.openapitools.model.RequestPasswordResetRequest
import org.openapitools.model.ResendVerificationCode200Response
import org.openapitools.model.ResendVerificationCodeRequest
import org.openapitools.model.ResetPassword200Response
import org.openapitools.model.ResetPassword400Response
import org.openapitools.model.ResetPasswordRequest
import org.openapitools.model.User
import org.openapitools.model.VerifyEmail400Response
import org.openapitools.model.VerifyEmail410Response
import org.openapitools.model.VerifyEmailRequest
import org.junit.jupiter.api.Test
import org.springframework.http.ResponseEntity

class AuthApiTest {

    private val api: AuthApiController = AuthApiController()

    /**
     * To test AuthApiController.authCheckGet
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun authCheckGetTest() {
        val response: ResponseEntity<Any> = api.authCheckGet()

        // TODO: test validations
    }

    /**
     * To test AuthApiController.authLogoutPost
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun authLogoutPostTest() {
        val response: ResponseEntity<Any> = api.authLogoutPost()

        // TODO: test validations
    }

    /**
     * To test AuthApiController.authRefreshPost
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun authRefreshPostTest() {
        val response: ResponseEntity<Any> = api.authRefreshPost()

        // TODO: test validations
    }

    /**
     * To test AuthApiController.loginUser
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun loginUserTest() {
        val loginUserRequest: LoginUserRequest = TODO()
        val response: ResponseEntity<Any> = api.loginUser(loginUserRequest)

        // TODO: test validations
    }

    /**
     * To test AuthApiController.registerUser
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun registerUserTest() {
        val registerUserRequest: RegisterUserRequest = TODO()
        val response: ResponseEntity<Any> = api.registerUser(registerUserRequest)

        // TODO: test validations
    }

    /**
     * To test AuthApiController.requestPasswordReset
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun requestPasswordResetTest() {
        val requestPasswordResetRequest: RequestPasswordResetRequest = TODO()
        val response: ResponseEntity<Any> = api.requestPasswordReset(requestPasswordResetRequest)

        // TODO: test validations
    }

    /**
     * To test AuthApiController.resendVerificationCode
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun resendVerificationCodeTest() {
        val resendVerificationCodeRequest: ResendVerificationCodeRequest = TODO()
        val response: ResponseEntity<Any> = api.resendVerificationCode(resendVerificationCodeRequest)

        // TODO: test validations
    }

    /**
     * To test AuthApiController.resetPassword
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun resetPasswordTest() {
        val resetPasswordRequest: ResetPasswordRequest = TODO()
        val response: ResponseEntity<Any> = api.resetPassword(resetPasswordRequest)

        // TODO: test validations
    }

    /**
     * To test AuthApiController.verifyEmail
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun verifyEmailTest() {
        val verifyEmailRequest: VerifyEmailRequest = TODO()
        val response: ResponseEntity<Any> = api.verifyEmail(verifyEmailRequest)

        // TODO: test validations
    }
}
