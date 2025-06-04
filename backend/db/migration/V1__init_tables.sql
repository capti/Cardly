-- Таблица users
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    username VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    is_enabled BOOLEAN NOT NULL DEFAULT FALSE,
    activation_token VARCHAR(255),
    password_reset_token VARCHAR(255),
    password_reset_token_expiry BIGINT,
    balance INTEGER NOT NULL DEFAULT 1000,
    avatar_url VARCHAR(255)
);

-- Таблица collections
CREATE TABLE collections (
    collection_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    image_url VARCHAR(255) NOT NULL
);

-- Таблица cards
CREATE TABLE cards (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    image_url VARCHAR(255) NOT NULL,
    rarity VARCHAR(50) NOT NULL,
    disassemble_price INTEGER NOT NULL,
    is_generated BOOLEAN NOT NULL,
    description TEXT,
    theme VARCHAR(255),
    collection_id INTEGER,
    owner_id INTEGER,
    CONSTRAINT fk_collection FOREIGN KEY (collection_id) REFERENCES collections(collection_id),
    CONSTRAINT fk_owner FOREIGN KEY (owner_id) REFERENCES users(user_id)
);

-- Таблица achievements
CREATE TABLE achievements (
    achievement_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    image_url VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    is_unlocked BOOLEAN NOT NULL DEFAULT FALSE
);

-- Таблица notifications
CREATE TABLE notifications (
    notification_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    message TEXT NOT NULL,
    notification_date_time TIMESTAMP NOT NULL,
    CONSTRAINT fk_user FOREIGN KEY(user_id) REFERENCES users(user_id)
);

-- Таблица packs
CREATE TABLE packs (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    image_url VARCHAR(255) NOT NULL,
    price INT NOT NULL
);

-- Таблица quests
CREATE TABLE quests (
    quest_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    progress INT NOT NULL,
    target INT NOT NULL,
    reward_coins INT NOT NULL,
    is_completed BOOLEAN NOT NULL,
    is_claimed BOOLEAN NOT NULL
);

-- Таблица user_inventory_cards (многие ко многим)
CREATE TABLE user_inventory_cards (
    user_id INTEGER NOT NULL,
    card_id INTEGER NOT NULL,
    PRIMARY KEY (user_id, card_id),
    CONSTRAINT fk_inventory_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_inventory_card FOREIGN KEY (card_id) REFERENCES cards(id) ON DELETE CASCADE
);

-- Таблица user_favorite_cards (многие ко многим)
CREATE TABLE user_favorite_cards (
    user_id INTEGER NOT NULL,
    card_id INTEGER NOT NULL,
    PRIMARY KEY (user_id, card_id),
    CONSTRAINT fk_favorite_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_favorite_card FOREIGN KEY (card_id) REFERENCES cards(id) ON DELETE CASCADE
);

-- Таблица user_onchange_cards (многие ко многим)
CREATE TABLE user_onchange_cards (
    user_id INTEGER NOT NULL,
    card_id INTEGER NOT NULL,
    PRIMARY KEY (user_id, card_id),
    CONSTRAINT fk_onchange_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_onchange_card FOREIGN KEY (card_id) REFERENCES cards(id) ON DELETE CASCADE
);

-- Таблица user_achievements (многие ко многим)
CREATE TABLE user_achievements (
    user_id INTEGER NOT NULL,
    achievement_id INTEGER NOT NULL,
    PRIMARY KEY (user_id, achievement_id),
    CONSTRAINT fk_achievements_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_achievements_achievement FOREIGN KEY (achievement_id) REFERENCES achievements(achievement_id) ON DELETE CASCADE
);

-- Таблица user_favorite_achievements (многие ко многим)
CREATE TABLE user_favorite_achievements (
    user_id INTEGER NOT NULL,
    achievement_id INTEGER NOT NULL,
    PRIMARY KEY (user_id, achievement_id),
    CONSTRAINT fk_favorite_achievements_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_favorite_achievements_achievement FOREIGN KEY (achievement_id) REFERENCES achievements(achievement_id) ON DELETE CASCADE
);

-- Таблица user_notifications (многие ко многим)
CREATE TABLE user_notifications (
    user_id INTEGER NOT NULL,
    notification_id INTEGER NOT NULL,
    PRIMARY KEY (user_id, notification_id),
    CONSTRAINT fk_notifications_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_notifications_notification FOREIGN KEY (notification_id) REFERENCES notifications(notification_id) ON DELETE CASCADE
);

-- Таблица pack_cards
CREATE TABLE pack_cards (
    pack_id BIGINT NOT NULL,
    card_id INT NOT NULL,
    CONSTRAINT fk_pack FOREIGN KEY (pack_id) REFERENCES packs(id) ON DELETE CASCADE,
    CONSTRAINT fk_card FOREIGN KEY (card_id) REFERENCES cards(id) ON DELETE CASCADE,
    PRIMARY KEY (pack_id, card_id)
);

-- Таблица quest_reward_packs
CREATE TABLE quest_reward_packs (
    quest_id INT NOT NULL,
    pack_id BIGINT NOT NULL,
    CONSTRAINT fk_quest FOREIGN KEY (quest_id) REFERENCES quests(quest_id) ON DELETE CASCADE,
    CONSTRAINT fk_pack FOREIGN KEY (pack_id) REFERENCES packs(id) ON DELETE CASCADE,
    PRIMARY KEY (quest_id, pack_id)
);

-- Таблица coin_offers
CREATE TABLE coin_offers (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    coins_amount INT NOT NULL,
    price DOUBLE PRECISION NOT NULL,
    image_url VARCHAR(255) NOT NULL,
    description VARCHAR(1000)
);

-- Таблица news_entity
CREATE TABLE news_entity (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL
);

-- Таблица notification_links
CREATE TABLE notification_links (
    notification_id INT NOT NULL,
    link TEXT NOT NULL,
    CONSTRAINT fk_notification FOREIGN KEY(notification_id) REFERENCES notifications(notification_id)
);

-- Таблица reports
CREATE TABLE reports (
    id BIGSERIAL PRIMARY KEY,
    reporter_id INT NOT NULL,
    reported_user_id INT NOT NULL,
    report_date_time TIMESTAMP NOT NULL,
    reason TEXT NOT NULL,
    status VARCHAR(50) NOT NULL,
    
    CONSTRAINT fk_reporter FOREIGN KEY (reporter_id) REFERENCES users(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_reported_user FOREIGN KEY (reported_user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Таблица user_stats
CREATE TABLE user_stats (
    id BIGSERIAL PRIMARY KEY,
    total_cards INT NOT NULL DEFAULT 0,
    completed_collections INT NOT NULL DEFAULT 0,
    user_id INT NOT NULL UNIQUE,
    
    CONSTRAINT fk_user_stats_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);
