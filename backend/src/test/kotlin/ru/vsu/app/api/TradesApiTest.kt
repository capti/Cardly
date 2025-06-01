package org.openapitools.api

import org.openapitools.model.OtherProfileCardCardIDInitiateTradePost400Response
import org.openapitools.model.InternalServerError
import org.openapitools.model.Trade
import org.openapitools.model.TradesInitiatePostRequest
import org.openapitools.model.TradesTradeIdAcceptPost200Response
import org.openapitools.model.TradesTradeIdAcceptPost403Response
import org.openapitools.model.TradesTradeIdCancelPost200Response
import org.openapitools.model.TradesTradeIdGet404Response
import org.openapitools.model.TradesTradeIdRejectPost200Response
import org.junit.jupiter.api.Test
import org.springframework.http.ResponseEntity

class TradesApiTest {

    private val api: TradesApiController = TradesApiController()

    /**
     * To test TradesApiController.tradesGet
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun tradesGetTest() {
        val search: kotlin.String? = TODO()
        val response: ResponseEntity<Any> = api.tradesGet(search)

        // TODO: test validations
    }

    /**
     * To test TradesApiController.tradesInitiatePost
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun tradesInitiatePostTest() {
        val tradesInitiatePostRequest: TradesInitiatePostRequest = TODO()
        val response: ResponseEntity<Any> = api.tradesInitiatePost(tradesInitiatePostRequest)

        // TODO: test validations
    }

    /**
     * To test TradesApiController.tradesMyGet
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun tradesMyGetTest() {
        val userId: kotlin.Int = TODO()
        val response: ResponseEntity<Any> = api.tradesMyGet(userId)

        // TODO: test validations
    }

    /**
     * To test TradesApiController.tradesTradeIdAcceptPost
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun tradesTradeIdAcceptPostTest() {
        val tradeId: kotlin.Int = TODO()
        val response: ResponseEntity<Any> = api.tradesTradeIdAcceptPost(tradeId)

        // TODO: test validations
    }

    /**
     * To test TradesApiController.tradesTradeIdCancelPost
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun tradesTradeIdCancelPostTest() {
        val tradeId: kotlin.Int = TODO()
        val response: ResponseEntity<Any> = api.tradesTradeIdCancelPost(tradeId)

        // TODO: test validations
    }

    /**
     * To test TradesApiController.tradesTradeIdGet
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun tradesTradeIdGetTest() {
        val tradeId: kotlin.Int = TODO()
        val response: ResponseEntity<Any> = api.tradesTradeIdGet(tradeId)

        // TODO: test validations
    }

    /**
     * To test TradesApiController.tradesTradeIdRejectPost
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun tradesTradeIdRejectPostTest() {
        val tradeId: kotlin.Int = TODO()
        val response: ResponseEntity<Any> = api.tradesTradeIdRejectPost(tradeId)

        // TODO: test validations
    }
}
