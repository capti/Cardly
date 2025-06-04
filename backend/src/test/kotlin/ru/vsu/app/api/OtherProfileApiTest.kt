package org.openapitools.api

import org.openapitools.model.OtherProfileCardCardIDInitiateTradePost200Response
import org.openapitools.model.OtherProfileCardCardIDInitiateTradePost400Response
import org.openapitools.model.OtherProfileCardCardIDInitiateTradePost409Response
import org.openapitools.model.OtherProfileCardCardIDViewGet200Response
import org.openapitools.model.OtherProfileInventorySortPost200Response
import org.openapitools.model.OtherProfileInventorySortPostRequest
import org.openapitools.model.OtherProfileUserIDGet200Response
import org.openapitools.model.OtherProfileUserIDInventoryGet200Response
import org.openapitools.model.OtherProfileUserIDInventoryGet403Response
import org.openapitools.model.OtherProfileUserIDReportPost200Response
import org.openapitools.model.OtherProfileUserIDReportPostRequest
import org.openapitools.model.ProfileAchievementsGet200Response
import org.openapitools.model.InternalServerError
import org.junit.jupiter.api.Test
import org.springframework.http.ResponseEntity

class OtherProfileApiTest {

    private val api: OtherProfileApiController = OtherProfileApiController()

    /**
     * To test OtherProfileApiController.otherProfileCardCardIDInitiateTradePost
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun otherProfileCardCardIDInitiateTradePostTest() {
        val cardID: kotlin.Int = TODO()
        val ownerID: kotlin.Int = TODO()
        val response: ResponseEntity<Any> = api.otherProfileCardCardIDInitiateTradePost(cardID, ownerID)

        // TODO: test validations
    }

    /**
     * To test OtherProfileApiController.otherProfileCardCardIDViewGet
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun otherProfileCardCardIDViewGetTest() {
        val cardID: kotlin.Int = TODO()
        val ownerID: kotlin.Int = TODO()
        val response: ResponseEntity<Any> = api.otherProfileCardCardIDViewGet(cardID, ownerID)

        // TODO: test validations
    }

    /**
     * To test OtherProfileApiController.otherProfileInventorySortPost
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun otherProfileInventorySortPostTest() {
        val userID: kotlin.Int = TODO()
        val otherProfileInventorySortPostRequest: OtherProfileInventorySortPostRequest = TODO()
        val response: ResponseEntity<Any> = api.otherProfileInventorySortPost(userID, otherProfileInventorySortPostRequest)

        // TODO: test validations
    }

    /**
     * To test OtherProfileApiController.otherProfileUserIDAchievementsGet
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun otherProfileUserIDAchievementsGetTest() {
        val userID: kotlin.Int = TODO()
        val response: ResponseEntity<Any> = api.otherProfileUserIDAchievementsGet(userID)

        // TODO: test validations
    }

    /**
     * To test OtherProfileApiController.otherProfileUserIDGet
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun otherProfileUserIDGetTest() {
        val userID: kotlin.Int = TODO()
        val response: ResponseEntity<Any> = api.otherProfileUserIDGet(userID)

        // TODO: test validations
    }

    /**
     * To test OtherProfileApiController.otherProfileUserIDInventoryGet
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun otherProfileUserIDInventoryGetTest() {
        val userID: kotlin.Int = TODO()
        val response: ResponseEntity<Any> = api.otherProfileUserIDInventoryGet(userID)

        // TODO: test validations
    }

    /**
     * To test OtherProfileApiController.otherProfileUserIDReportPost
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun otherProfileUserIDReportPostTest() {
        val userID: kotlin.Int = TODO()
        val otherProfileUserIDReportPostRequest: OtherProfileUserIDReportPostRequest = TODO()
        val response: ResponseEntity<Any> = api.otherProfileUserIDReportPost(userID, otherProfileUserIDReportPostRequest)

        // TODO: test validations
    }
}
