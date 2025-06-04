package org.openapitools.api

import org.openapitools.model.ProfileAchievementsFavoritesCountGet200Response
import org.openapitools.model.ProfileAchievementsGet200Response
import org.openapitools.model.ProfileGet200Response
import org.openapitools.model.InternalServerError
import org.openapitools.model.UserSettings
import org.junit.jupiter.api.Test
import org.springframework.http.ResponseEntity

class ProfileApiTest {

    private val api: ProfileApiController = ProfileApiController()

    /**
     * To test ProfileApiController.profileAchievementsAchievementIDFavoriteAddPost
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun profileAchievementsAchievementIDFavoriteAddPostTest() {
        val achievementID: kotlin.Int = TODO()
        val response: ResponseEntity<Any> = api.profileAchievementsAchievementIDFavoriteAddPost(achievementID)

        // TODO: test validations
    }

    /**
     * To test ProfileApiController.profileAchievementsAchievementIDFavoriteDeleteDelete
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun profileAchievementsAchievementIDFavoriteDeleteDeleteTest() {
        val achievementID: kotlin.Int = TODO()
        val response: ResponseEntity<Any> = api.profileAchievementsAchievementIDFavoriteDeleteDelete(achievementID)

        // TODO: test validations
    }

    /**
     * To test ProfileApiController.profileAchievementsFavoritesCountGet
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun profileAchievementsFavoritesCountGetTest() {
        val response: ResponseEntity<Any> = api.profileAchievementsFavoritesCountGet()

        // TODO: test validations
    }

    /**
     * To test ProfileApiController.profileAchievementsGet
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun profileAchievementsGetTest() {
        val response: ResponseEntity<Any> = api.profileAchievementsGet()

        // TODO: test validations
    }

    /**
     * To test ProfileApiController.profileGet
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun profileGetTest() {
        val response: ResponseEntity<Any> = api.profileGet()

        // TODO: test validations
    }

    /**
     * To test ProfileApiController.profileSettingsChangePut
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun profileSettingsChangePutTest() {
        val userSettings: UserSettings = TODO()
        val response: ResponseEntity<Any> = api.profileSettingsChangePut(userSettings)

        // TODO: test validations
    }

    /**
     * To test ProfileApiController.profileSettingsGet
     *
     * @throws ApiException
     *          if the Api call fails
     */
    @Test
    fun profileSettingsGetTest() {
        val response: ResponseEntity<Any> = api.profileSettingsGet()

        // TODO: test validations
    }
}
