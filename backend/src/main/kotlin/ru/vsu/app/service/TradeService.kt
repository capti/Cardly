package ru.vsu.app.service

import ru.vsu.app.dto.TradeDto
import ru.vsu.app.dto.requests.AdminTradesTradeIDInvalidatePostRequest
import ru.vsu.app.dto.responses.admin.AdminTradesTradeIDInvalidatePost200Response
import org.springframework.stereotype.Service

@Service
class TradeService {
    fun getAllTrades(): List<TradeDto> {
        // Implementation for getting all trades
        return emptyList()
    }

    fun invalidateTrade(tradeID: Int, request: AdminTradesTradeIDInvalidatePostRequest): AdminTradesTradeIDInvalidatePost200Response {
        // Implementation for invalidating a trade
        return AdminTradesTradeIDInvalidatePost200Response()
    }
}
