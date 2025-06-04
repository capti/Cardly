package ru.vsu.app.service

import ru.vsu.app.dto.TradeDto
import ru.vsu.app.dto.requests.AdminTradesTradeIDInvalidatePostRequest
import ru.vsu.app.dto.responses.admin.AdminTradesTradeIDInvalidatePost200Response

interface TradeAdminService {
    fun getAllTrades(): List<TradeDto>
    fun invalidateTrade(tradeID: Int, request: AdminTradesTradeIDInvalidatePostRequest): AdminTradesTradeIDInvalidatePost200Response
} 