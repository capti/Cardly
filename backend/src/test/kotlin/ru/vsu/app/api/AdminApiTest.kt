package org.openapitools.api

import org.openapitools.model.Achievement
import org.openapitools.model.AdminReportsReportIDPutRequest
import org.openapitools.model.AdminStatsGet200Response
import org.openapitools.model.AdminTradesTradeIDInvalidatePost200Response
import org.openapitools.model.AdminTradesTradeIDInvalidatePostRequest
import org.openapitools.model.AdminUsersUserIDBanPost200Response
import org.openapitools.model.AdminUsersUserIDBanPostRequest
import org.openapitools.model.AdminUsersUserIDQuestsQuestIDResetPost200Response
import org.openapitools.model.AdminUsersUserIDQuestsQuestIDResetPostRequest
import org.openapitools.model.AdminUsersUserIDUnbanPost200Response
import org.openapitools.model.Card
import org.openapitools.model.CoinOffer
import org.openapitools.model.Collection
import org.openapitools.model.News
import org.openapitools.model.Pack
import org.openapitools.model.InternalServerError
import org.openapitools.model.Report
import org.openapitools.model.Trade
import org.junit.jupiter.api.Test
import org.springframework.http.ResponseEntity

class AdminApiTest {

    private val api: AdminApiController = AdminApiController()

    /**
     * To test AdminApiController.adminAchievementsAchievementIDDelete
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun adminAchievementsAchievementIDDeleteTest() {
        val achievementID: kotlin.Int = TODO()
        val response: ResponseEntity<Any> = api.adminAchievementsAchievementIDDelete(achievementID)

        // TODO: test validations
    }

    /**
     * To test AdminApiController.adminAchievementsAchievementIDPut
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun adminAchievementsAchievementIDPutTest() {
        val achievementID: kotlin.Int = TODO()
        val achievement: Achievement = TODO()
        val response: ResponseEntity<Any> = api.adminAchievementsAchievementIDPut(achievementID, achievement)

        // TODO: test validations
    }

    /**
     * To test AdminApiController.adminAchievementsPost
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun adminAchievementsPostTest() {
        val achievement: Achievement = TODO()
        val response: ResponseEntity<Any> = api.adminAchievementsPost(achievement)

        // TODO: test validations
    }

    /**
     * To test AdminApiController.adminCardsCardIDDelete
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun adminCardsCardIDDeleteTest() {
        val cardID: kotlin.Int = TODO()
        val response: ResponseEntity<Any> = api.adminCardsCardIDDelete(cardID)

        // TODO: test validations
    }

    /**
     * To test AdminApiController.adminCardsCardIDPut
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun adminCardsCardIDPutTest() {
        val cardID: kotlin.Int = TODO()
        val card: Card = TODO()
        val response: ResponseEntity<Any> = api.adminCardsCardIDPut(cardID, card)

        // TODO: test validations
    }

    /**
     * To test AdminApiController.adminCardsPost
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun adminCardsPostTest() {
        val card: Card = TODO()
        val response: ResponseEntity<Any> = api.adminCardsPost(card)

        // TODO: test validations
    }

    /**
     * To test AdminApiController.adminCoinOffersGet
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun adminCoinOffersGetTest() {
        val response: ResponseEntity<Any> = api.adminCoinOffersGet()

        // TODO: test validations
    }

    /**
     * To test AdminApiController.adminCoinOffersOfferIdDelete
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun adminCoinOffersOfferIdDeleteTest() {
        val offerId: kotlin.Int = TODO()
        val response: ResponseEntity<Any> = api.adminCoinOffersOfferIdDelete(offerId)

        // TODO: test validations
    }

    /**
     * To test AdminApiController.adminCoinOffersOfferIdPut
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun adminCoinOffersOfferIdPutTest() {
        val offerId: kotlin.Int = TODO()
        val coinOffer: CoinOffer = TODO()
        val response: ResponseEntity<Any> = api.adminCoinOffersOfferIdPut(offerId, coinOffer)

        // TODO: test validations
    }

    /**
     * To test AdminApiController.adminCoinOffersPost
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun adminCoinOffersPostTest() {
        val coinOffer: CoinOffer = TODO()
        val response: ResponseEntity<Any> = api.adminCoinOffersPost(coinOffer)

        // TODO: test validations
    }

    /**
     * To test AdminApiController.adminCollectionsCollectionIDDelete
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun adminCollectionsCollectionIDDeleteTest() {
        val collectionID: kotlin.Int = TODO()
        val response: ResponseEntity<Any> = api.adminCollectionsCollectionIDDelete(collectionID)

        // TODO: test validations
    }

    /**
     * To test AdminApiController.adminCollectionsCollectionIDPut
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun adminCollectionsCollectionIDPutTest() {
        val collectionID: kotlin.Int = TODO()
        val collection: Collection = TODO()
        val response: ResponseEntity<Any> = api.adminCollectionsCollectionIDPut(collectionID, collection)

        // TODO: test validations
    }

    /**
     * To test AdminApiController.adminCollectionsPost
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun adminCollectionsPostTest() {
        val collection: Collection = TODO()
        val response: ResponseEntity<Any> = api.adminCollectionsPost(collection)

        // TODO: test validations
    }

    /**
     * To test AdminApiController.adminNewsNewsIDDelete
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun adminNewsNewsIDDeleteTest() {
        val newsID: kotlin.Int = TODO()
        val response: ResponseEntity<Any> = api.adminNewsNewsIDDelete(newsID)

        // TODO: test validations
    }

    /**
     * To test AdminApiController.adminNewsNewsIDPut
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun adminNewsNewsIDPutTest() {
        val newsID: kotlin.Int = TODO()
        val news: News = TODO()
        val response: ResponseEntity<Any> = api.adminNewsNewsIDPut(newsID, news)

        // TODO: test validations
    }

    /**
     * To test AdminApiController.adminNewsPost
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun adminNewsPostTest() {
        val news: News = TODO()
        val response: ResponseEntity<Any> = api.adminNewsPost(news)

        // TODO: test validations
    }

    /**
     * To test AdminApiController.adminPacksPackIDDelete
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun adminPacksPackIDDeleteTest() {
        val packID: kotlin.Int = TODO()
        val response: ResponseEntity<Any> = api.adminPacksPackIDDelete(packID)

        // TODO: test validations
    }

    /**
     * To test AdminApiController.adminPacksPackIDPut
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun adminPacksPackIDPutTest() {
        val packID: kotlin.Int = TODO()
        val pack: Pack = TODO()
        val response: ResponseEntity<Any> = api.adminPacksPackIDPut(packID, pack)

        // TODO: test validations
    }

    /**
     * To test AdminApiController.adminPacksPost
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun adminPacksPostTest() {
        val pack: Pack = TODO()
        val response: ResponseEntity<Any> = api.adminPacksPost(pack)

        // TODO: test validations
    }

    /**
     * To test AdminApiController.adminReportsGet
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun adminReportsGetTest() {
        val response: ResponseEntity<Any> = api.adminReportsGet()

        // TODO: test validations
    }

    /**
     * To test AdminApiController.adminReportsReportIDGet
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun adminReportsReportIDGetTest() {
        val reportID: kotlin.Int = TODO()
        val response: ResponseEntity<Any> = api.adminReportsReportIDGet(reportID)

        // TODO: test validations
    }

    /**
     * To test AdminApiController.adminReportsReportIDPut
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun adminReportsReportIDPutTest() {
        val reportID: kotlin.Int = TODO()
        val adminReportsReportIDPutRequest: AdminReportsReportIDPutRequest = TODO()
        val response: ResponseEntity<Any> = api.adminReportsReportIDPut(reportID, adminReportsReportIDPutRequest)

        // TODO: test validations
    }

    /**
     * To test AdminApiController.adminStatsGet
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun adminStatsGetTest() {
        val response: ResponseEntity<Any> = api.adminStatsGet()

        // TODO: test validations
    }

    /**
     * To test AdminApiController.adminTradesGet
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun adminTradesGetTest() {
        val response: ResponseEntity<Any> = api.adminTradesGet()

        // TODO: test validations
    }

    /**
     * To test AdminApiController.adminTradesTradeIDInvalidatePost
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun adminTradesTradeIDInvalidatePostTest() {
        val tradeID: kotlin.Int = TODO()
        val adminTradesTradeIDInvalidatePostRequest: AdminTradesTradeIDInvalidatePostRequest = TODO()
        val response: ResponseEntity<Any> = api.adminTradesTradeIDInvalidatePost(tradeID, adminTradesTradeIDInvalidatePostRequest)

        // TODO: test validations
    }

    /**
     * To test AdminApiController.adminUsersUserIDAchievementsAchievementIDDelete
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun adminUsersUserIDAchievementsAchievementIDDeleteTest() {
        val userID: kotlin.Int = TODO()
        val achievementID: kotlin.Int = TODO()
        val response: ResponseEntity<Any> = api.adminUsersUserIDAchievementsAchievementIDDelete(userID, achievementID)

        // TODO: test validations
    }

    /**
     * To test AdminApiController.adminUsersUserIDBanPost
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun adminUsersUserIDBanPostTest() {
        val userID: kotlin.Int = TODO()
        val adminUsersUserIDBanPostRequest: AdminUsersUserIDBanPostRequest = TODO()
        val response: ResponseEntity<Any> = api.adminUsersUserIDBanPost(userID, adminUsersUserIDBanPostRequest)

        // TODO: test validations
    }

    /**
     * To test AdminApiController.adminUsersUserIDDeleteDelete
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun adminUsersUserIDDeleteDeleteTest() {
        val userID: kotlin.Int = TODO()
        val response: ResponseEntity<Any> = api.adminUsersUserIDDeleteDelete(userID)

        // TODO: test validations
    }

    /**
     * To test AdminApiController.adminUsersUserIDInventoryCardIDDelete
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun adminUsersUserIDInventoryCardIDDeleteTest() {
        val userID: kotlin.Int = TODO()
        val cardID: kotlin.Int = TODO()
        val response: ResponseEntity<Any> = api.adminUsersUserIDInventoryCardIDDelete(userID, cardID)

        // TODO: test validations
    }

    /**
     * To test AdminApiController.adminUsersUserIDQuestsQuestIDResetPost
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun adminUsersUserIDQuestsQuestIDResetPostTest() {
        val userID: kotlin.Int = TODO()
        val questID: kotlin.Int = TODO()
        val adminUsersUserIDQuestsQuestIDResetPostRequest: AdminUsersUserIDQuestsQuestIDResetPostRequest = TODO()
        val response: ResponseEntity<Any> = api.adminUsersUserIDQuestsQuestIDResetPost(userID, questID, adminUsersUserIDQuestsQuestIDResetPostRequest)

        // TODO: test validations
    }

    /**
     * To test AdminApiController.adminUsersUserIDUnbanPost
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun adminUsersUserIDUnbanPostTest() {
        val userID: kotlin.Int = TODO()
        val response: ResponseEntity<Any> = api.adminUsersUserIDUnbanPost(userID)

        // TODO: test validations
    }
}
