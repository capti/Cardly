package ru.vsu.app.util

import java.util.Optional

fun <T> Optional<T>.toNullable(): T? = this.orElse(null)
