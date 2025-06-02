package ru.vsu.app.metrics

object MetricTags {
    fun user(id: String) = "userId" to id
    fun source(value: String) = "source" to value
}
