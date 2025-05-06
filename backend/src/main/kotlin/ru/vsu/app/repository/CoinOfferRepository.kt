package ru.vsu.app.repository

import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository
import ru.vsu.app.model.CoinOffer

@Repository
interface CoinOfferRepository : JpaRepository<CoinOffer, Long> 