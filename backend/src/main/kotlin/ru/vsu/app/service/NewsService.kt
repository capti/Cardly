package ru.vsu.app.service

import ru.vsu.app.dto.NewsDto
import org.springframework.stereotype.Service

@Service
class NewsService {
    fun deleteNews(newsID: Int) {
        // Implementation for deleting news
    }

    fun updateNews(newsID: Int, news: NewsDto): NewsDto {
        // Implementation for updating news
        return news
    }

    fun createNews(news: NewsDto): NewsDto {
        // Implementation for creating news
        return news
    }
}
