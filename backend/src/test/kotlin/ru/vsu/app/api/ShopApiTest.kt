package org.openapitools.api

import org.openapitools.model.CoinOffer
import org.openapitools.model.Pack
import org.openapitools.model.PaymentCallback
import org.openapitools.model.InternalServerError
import org.openapitools.model.ShopCoinsOffersOfferIdPurchasePost200Response
import org.openapitools.model.ShopCoinsOffersOfferIdPurchasePostRequest
import org.openapitools.model.ShopPacksPackIdBuyPost200Response
import org.openapitools.model.ShopPacksPackIdBuyPost402Response
import org.openapitools.model.ShopPacksPackIdOpenPost200Response
import org.openapitools.model.ShopPaymentsProcessPost200Response
import org.junit.jupiter.api.Test
import org.springframework.http.ResponseEntity

class ShopApiTest {

    private val api: ShopApiController = ShopApiController()

    /**
     * To test ShopApiController.shopCoinsOffersGet
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun shopCoinsOffersGetTest() {
        val response: ResponseEntity<Any> = api.shopCoinsOffersGet()

        // TODO: test validations
    }

    /**
     * To test ShopApiController.shopCoinsOffersOfferIdGet
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun shopCoinsOffersOfferIdGetTest() {
        val offerId: kotlin.Int = TODO()
        val response: ResponseEntity<Any> = api.shopCoinsOffersOfferIdGet(offerId)

        // TODO: test validations
    }

    /**
     * To test ShopApiController.shopCoinsOffersOfferIdPurchasePost
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun shopCoinsOffersOfferIdPurchasePostTest() {
        val offerId: kotlin.Int = TODO()
        val shopCoinsOffersOfferIdPurchasePostRequest: ShopCoinsOffersOfferIdPurchasePostRequest = TODO()
        val response: ResponseEntity<Any> = api.shopCoinsOffersOfferIdPurchasePost(offerId, shopCoinsOffersOfferIdPurchasePostRequest)

        // TODO: test validations
    }

    /**
     * To test ShopApiController.shopPacksGet
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun shopPacksGetTest() {
        val response: ResponseEntity<Any> = api.shopPacksGet()

        // TODO: test validations
    }

    /**
     * To test ShopApiController.shopPacksPackIdBuyPost
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun shopPacksPackIdBuyPostTest() {
        val packId: kotlin.Int = TODO()
        val response: ResponseEntity<Any> = api.shopPacksPackIdBuyPost(packId)

        // TODO: test validations
    }

    /**
     * To test ShopApiController.shopPacksPackIdGet
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun shopPacksPackIdGetTest() {
        val packId: kotlin.Int = TODO()
        val response: ResponseEntity<Any> = api.shopPacksPackIdGet(packId)

        // TODO: test validations
    }

    /**
     * To test ShopApiController.shopPacksPackIdOpenPost
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun shopPacksPackIdOpenPostTest() {
        val packId: kotlin.Int = TODO()
        val response: ResponseEntity<Any> = api.shopPacksPackIdOpenPost(packId)

        // TODO: test validations
    }

    /**
     * To test ShopApiController.shopPaymentsProcessPost
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun shopPaymentsProcessPostTest() {
        val paymentCallback: PaymentCallback = TODO()
        val response: ResponseEntity<Any> = api.shopPaymentsProcessPost(paymentCallback)

        // TODO: test validations
    }
}
