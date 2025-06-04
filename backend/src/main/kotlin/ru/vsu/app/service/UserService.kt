package ru.vsu.app.service

import ru.vsu.app.dto.requests.AdminUsersUserIDBanPostRequest
import ru.vsu.app.dto.requests.AdminUsersUserIDQuestsQuestIDResetPostRequest
import ru.vsu.app.dto.responses.admin.AdminUsersUserIDBanPost200Response
import ru.vsu.app.dto.responses.admin.AdminUsersUserIDQuestsQuestIDResetPost200Response
import ru.vsu.app.dto.responses.admin.AdminUsersUserIDUnbanPost200Response
import org.springframework.stereotype.Service

@Service
class UserService {
    fun revokeAchievement(userID: Int, achievementID: Int) {
        // Implementation for revoking an achievement from a user
    }

    fun banUser(userID: Int, request: AdminUsersUserIDBanPostRequest): AdminUsersUserIDBanPost200Response {
        // Implementation for banning a user
        return AdminUsersUserIDBanPost200Response()
    }

    fun deleteUser(userID: Int) {
        // Implementation for deleting a user
    }

    fun deleteCardFromInventory(userID: Int, cardID: Int) {
        // Implementation for deleting a card from a user's inventory
    }

    fun resetQuest(userID: Int, questID: Int, request: AdminUsersUserIDQuestsQuestIDResetPostRequest): AdminUsersUserIDQuestsQuestIDResetPost200Response {
        // Implementation for resetting a quest for a user
        return AdminUsersUserIDQuestsQuestIDResetPost200Response()
    }

    fun unbanUser(userID: Int): AdminUsersUserIDUnbanPost200Response {
        // Implementation for unbanning a user
        return AdminUsersUserIDUnbanPost200Response()
    }
}
