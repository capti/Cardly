package ru.vsu.app.service

import org.springframework.stereotype.Service
import ru.vsu.app.repository.NewsRepository
import ru.vsu.app.dto.requests.NewsRequest
import ru.vsu.app.dto.responses.home.NewsResponse
import ru.vsu.app.model.NewsEntity
import java.time.LocalDateTime

@Service
class NewsService(
    private var newsRepository: NewsRepository
) {

    fun createNews(request: NewsRequest): NewsResponse {
        var news = NewsEntity(
            title = request.title,
            content = request.content,
            createdAt = LocalDateTime.now(),
            updatedAt = LocalDateTime.now()
        )
        return toResponse(newsRepository.save(news))
    }

    fun updateNews(id: Int, request: NewsRequest): NewsResponse {
        var news = newsRepository.findById(id)
            .orElseThrow { RuntimeException("Новость не найдена") }

        news.title = request.title
        news.content = request.content
        news.updatedAt = LocalDateTime.now()

        return toResponse(newsRepository.save(news))
    }

    fun deleteNews(id: Int) {
        newsRepository.deleteById(id)
    }

    private fun toResponse(news: NewsEntity): NewsResponse {
        return NewsResponse(
            id = news.id!!,
            title = news.title,
            content = news.content,
            createdAt = news.createdAt,
            updatedAt = news.updatedAt
        )
    }
}
