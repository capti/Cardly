package ru.vsu.app.model

import jakarta.persistence.*

@Entity
@Table(name = "quests")
data class QuestEntity(

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "quest_id")
    val questID: Int = 0,

    @Column(nullable = false)
    val name: String,

    @Column(nullable = false)
    val description: String,

    @Column(nullable = false)
    val progress: Int,

    @Column(nullable = false)
    val target: Int,

    @Column(name = "reward_coins", nullable = false)
    val rewardCoins: Int,

    @Column(name = "is_completed", nullable = false)
    val isCompleted: Boolean,

    @Column(name = "is_claimed", nullable = false)
    val isClaimed: Boolean,

    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
        name = "quest_reward_packs",
        joinColumns = [JoinColumn(name = "quest_id")],
        inverseJoinColumns = [JoinColumn(name = "pack_id")]
    )
    val rewardPacks: List<PackEntity>? = null
)
