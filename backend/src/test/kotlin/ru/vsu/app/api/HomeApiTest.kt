package org.openapitools.api

import org.openapitools.model.HomeGenerateCardPost200Response
import org.openapitools.model.HomeGenerateCardPost402Response
import org.openapitools.model.HomeGenerateCardPostRequest
import org.openapitools.model.HomeNewsGet404Response
import org.openapitools.model.HomeNotificationsNotificationIDNavigatePost200Response
import org.openapitools.model.HomeNotificationsNotificationIDNavigatePost404Response
import org.openapitools.model.HomeQuestsClaimRewardPost200Response
import org.openapitools.model.HomeQuestsClaimRewardPost400Response
import org.openapitools.model.HomeQuestsClaimRewardPostRequest
import org.openapitools.model.HomeQuestsGet200Response
import org.openapitools.model.HomeQuestsQuestIDChangeStatusPost200Response
import org.openapitools.model.HomeSearchGet400Response
import org.openapitools.model.HomeSearchGet404Response
import org.openapitools.model.News
import org.openapitools.model.Notification
import org.openapitools.model.InternalServerError
import org.openapitools.model.Theme
import org.openapitools.model.User
import org.junit.jupiter.api.Test
import org.springframework.http.ResponseEntity

class HomeApiTest {

    private val api: HomeApiController = HomeApiController()

    /**
     * To test HomeApiController.homeGenerateCardPost
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun homeGenerateCardPostTest() {
        val homeGenerateCardPostRequest: HomeGenerateCardPostRequest = TODO()
        val response: ResponseEntity<Any> = api.homeGenerateCardPost(homeGenerateCardPostRequest)

        // TODO: test validations
    }

    /**
     * To test HomeApiController.homeGenerateCardThemesGet
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun homeGenerateCardThemesGetTest() {
        val response: ResponseEntity<Any> = api.homeGenerateCardThemesGet()

        // TODO: test validations
    }

    /**
     * To test HomeApiController.homeNewsGet
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun homeNewsGetTest() {
        val response: ResponseEntity<Any> = api.homeNewsGet()

        // TODO: test validations
    }

    /**
     * To test HomeApiController.homeNewsNewsIDGet
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun homeNewsNewsIDGetTest() {
        val newsID: kotlin.Int = TODO()
        val response: ResponseEntity<Any> = api.homeNewsNewsIDGet(newsID)

        // TODO: test validations
    }

    /**
     * To test HomeApiController.homeNotificationsGet
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun homeNotificationsGetTest() {
        val response: ResponseEntity<Any> = api.homeNotificationsGet()

        // TODO: test validations
    }

    /**
     * To test HomeApiController.homeNotificationsNotificationIDGet
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun homeNotificationsNotificationIDGetTest() {
        val notificationID: kotlin.Int = TODO()
        val response: ResponseEntity<Any> = api.homeNotificationsNotificationIDGet(notificationID)

        // TODO: test validations
    }

    /**
     * To test HomeApiController.homeNotificationsNotificationIDNavigatePost
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun homeNotificationsNotificationIDNavigatePostTest() {
        val notificationID: kotlin.Int = TODO()
        val response: ResponseEntity<Any> = api.homeNotificationsNotificationIDNavigatePost(notificationID)

        // TODO: test validations
    }

    /**
     * To test HomeApiController.homeQuestsClaimRewardPost
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun homeQuestsClaimRewardPostTest() {
        val homeQuestsClaimRewardPostRequest: HomeQuestsClaimRewardPostRequest = TODO()
        val response: ResponseEntity<Any> = api.homeQuestsClaimRewardPost(homeQuestsClaimRewardPostRequest)

        // TODO: test validations
    }

    /**
     * To test HomeApiController.homeQuestsGet
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun homeQuestsGetTest() {
        val response: ResponseEntity<Any> = api.homeQuestsGet()

        // TODO: test validations
    }

    /**
     * To test HomeApiController.homeQuestsQuestIDChangeStatusPost
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun homeQuestsQuestIDChangeStatusPostTest() {
        val questID: kotlin.Int = TODO()
        val response: ResponseEntity<Any> = api.homeQuestsQuestIDChangeStatusPost(questID)

        // TODO: test validations
    }

    /**
     * To test HomeApiController.homeSearchGet
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun homeSearchGetTest() {
        val query: kotlin.String? = TODO()
        val response: ResponseEntity<Any> = api.homeSearchGet(query)

        // TODO: test validations
    }
}
