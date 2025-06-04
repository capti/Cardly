package ru.vsu.app.repository

import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository
import ru.vsu.app.model.CoinOfferEntity

@Repository
interface CoinOfferRepository : JpaRepository<CoinOfferEntity, Long> 