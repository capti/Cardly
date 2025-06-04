package org.openapitools.api

import org.openapitools.model.InventoryCardCardIDFavoriteGet200Response
import org.openapitools.model.InventoryCardCardIDQuantityGet200Response
import org.openapitools.model.InventoryCardCardIDTradeCancelPost200Response
import org.openapitools.model.InventoryCardCardIDTradeStatusGet200Response
import org.openapitools.model.InventoryDestroyPost200Response
import org.openapitools.model.InventoryDestroyPostRequest
import org.openapitools.model.InventoryFavoritesCountGet200Response
import org.openapitools.model.InventoryGet200Response
import org.openapitools.model.InventorySortPost200Response
import org.openapitools.model.OtherProfileCardCardIDInitiateTradePost200Response
import org.openapitools.model.OtherProfileInventorySortPostRequest
import org.openapitools.model.InternalServerError
import org.junit.jupiter.api.Test
import org.springframework.http.ResponseEntity

class InventoryApiTest {

    private val api: InventoryApiController = InventoryApiController()

    /**
     * To test InventoryApiController.inventoryCardCardIDFavoriteAddPost
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun inventoryCardCardIDFavoriteAddPostTest() {
        val cardID: kotlin.Int = TODO()
        val response: ResponseEntity<Any> = api.inventoryCardCardIDFavoriteAddPost(cardID)

        // TODO: test validations
    }

    /**
     * To test InventoryApiController.inventoryCardCardIDFavoriteDeleteDelete
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun inventoryCardCardIDFavoriteDeleteDeleteTest() {
        val cardID: kotlin.Int = TODO()
        val response: ResponseEntity<Any> = api.inventoryCardCardIDFavoriteDeleteDelete(cardID)

        // TODO: test validations
    }

    /**
     * To test InventoryApiController.inventoryCardCardIDFavoriteGet
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun inventoryCardCardIDFavoriteGetTest() {
        val cardID: kotlin.Int = TODO()
        val response: ResponseEntity<Any> = api.inventoryCardCardIDFavoriteGet(cardID)

        // TODO: test validations
    }

    /**
     * To test InventoryApiController.inventoryCardCardIDQuantityGet
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun inventoryCardCardIDQuantityGetTest() {
        val cardID: kotlin.Int = TODO()
        val response: ResponseEntity<Any> = api.inventoryCardCardIDQuantityGet(cardID)

        // TODO: test validations
    }

    /**
     * To test InventoryApiController.inventoryCardCardIDTradeCancelPost
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun inventoryCardCardIDTradeCancelPostTest() {
        val cardID: kotlin.Int = TODO()
        val response: ResponseEntity<Any> = api.inventoryCardCardIDTradeCancelPost(cardID)

        // TODO: test validations
    }

    /**
     * To test InventoryApiController.inventoryCardCardIDTradeStatusGet
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun inventoryCardCardIDTradeStatusGetTest() {
        val cardID: kotlin.Int = TODO()
        val response: ResponseEntity<Any> = api.inventoryCardCardIDTradeStatusGet(cardID)

        // TODO: test validations
    }

    /**
     * To test InventoryApiController.inventoryDestroyPost
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun inventoryDestroyPostTest() {
        val inventoryDestroyPostRequest: InventoryDestroyPostRequest = TODO()
        val response: ResponseEntity<Any> = api.inventoryDestroyPost(inventoryDestroyPostRequest)

        // TODO: test validations
    }

    /**
     * To test InventoryApiController.inventoryFavoritesCountGet
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun inventoryFavoritesCountGetTest() {
        val response: ResponseEntity<Any> = api.inventoryFavoritesCountGet()

        // TODO: test validations
    }

    /**
     * To test InventoryApiController.inventoryGet
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun inventoryGetTest() {
        val response: ResponseEntity<Any> = api.inventoryGet()

        // TODO: test validations
    }

    /**
     * To test InventoryApiController.inventoryPutOnTradePost
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun inventoryPutOnTradePostTest() {
        val inventoryDestroyPostRequest: InventoryDestroyPostRequest = TODO()
        val response: ResponseEntity<Any> = api.inventoryPutOnTradePost(inventoryDestroyPostRequest)

        // TODO: test validations
    }

    /**
     * To test InventoryApiController.inventorySortPost
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun inventorySortPostTest() {
        val otherProfileInventorySortPostRequest: OtherProfileInventorySortPostRequest = TODO()
        val response: ResponseEntity<Any> = api.inventorySortPost(otherProfileInventorySortPostRequest)

        // TODO: test validations
    }
}
