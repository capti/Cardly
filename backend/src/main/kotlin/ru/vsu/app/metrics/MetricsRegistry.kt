package ru.vsu.app.metrics

import io.micrometer.core.instrument.MeterRegistry
import org.springframework.stereotype.Component
import java.util.concurrent.TimeUnit

@Component
class MetricsRegistry(private val registry: MeterRegistry) {

    fun count(name: String, tags: List<Pair<String, String>> = emptyList()) {
        registry.counter(name, *tags.toTypedArray().flatMap { listOf(it.first, it.second) }.toTypedArray()).increment()
    }

    fun timer(name: String, durationMillis: Long, tags: List<Pair<String, String>> = emptyList()) {
        registry.timer(name, *tags.toTypedArray().flatMap { listOf(it.first, it.second) }.toTypedArray())
            .record(durationMillis, TimeUnit.MILLISECONDS)
    }
}
