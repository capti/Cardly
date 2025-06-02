package ru.vsu.app

import io.github.cdimascio.dotenv.Dotenv
import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication

@SpringBootApplication
class Application

fun main(args: Array<String>) {
    val dotenv = Dotenv.configure()
        .ignoreIfMissing()
        .load()

    dotenv.entries().forEach { entry ->
        if (System.getenv(entry.key) == null && System.getProperty(entry.key) == null) {
            System.setProperty(entry.key, entry.value)
        }
    }

    runApplication<Application>(*args)
}
