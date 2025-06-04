-- Таблица тем
CREATE TABLE themes (
    theme_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT
);

-- Таблица настроек пользователя
CREATE TABLE user_settings (
    settings_id SERIAL PRIMARY KEY,
    notifications_enabled BOOLEAN NOT NULL,
    show_inventory BOOLEAN NOT NULL,
    auto_decline_trades BOOLEAN NOT NULL,
    user_id INT NOT NULL UNIQUE,
    CONSTRAINT fk_user_settings_user FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Таблица платежей
CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    payment_sum DOUBLE PRECISION NOT NULL,
    payment_status VARCHAR(50) NOT NULL,
    payment_datetime TIMESTAMP NOT NULL,
    CONSTRAINT fk_payments_user FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Таблица с данными карты (элемент коллекции)
CREATE TABLE payment_card_data (
    payment_id INT NOT NULL,
    card_data TEXT,
    CONSTRAINT fk_payment_card_data FOREIGN KEY (payment_id) REFERENCES payments(payment_id)
);

-- Таблица обменов
CREATE TABLE trades (
    trade_id SERIAL PRIMARY KEY,
    offering_user_id INT NOT NULL,
    receiving_user_id INT NOT NULL,
    is_confirmed BOOLEAN NOT NULL,
    trade_date_time TIMESTAMP NOT NULL,
    CONSTRAINT fk_trades_offering_user FOREIGN KEY (offering_user_id) REFERENCES users(user_id),
    CONSTRAINT fk_trades_receiving_user FOREIGN KEY (receiving_user_id) REFERENCES users(user_id)
);

-- Связь trade -> offeringCards
CREATE TABLE trade_offering_cards (
    trade_id INT NOT NULL,
    card_id INT NOT NULL,
    PRIMARY KEY (trade_id, card_id),
    CONSTRAINT fk_trade_offering_cards_trade FOREIGN KEY (trade_id) REFERENCES trades(trade_id),
    CONSTRAINT fk_trade_offering_cards_card FOREIGN KEY (card_id) REFERENCES cards(id)
);

-- Связь trade -> receivingCards
CREATE TABLE trade_receiving_cards (
    trade_id INT NOT NULL,
    card_id INT NOT NULL,
    PRIMARY KEY (trade_id, card_id),
    CONSTRAINT fk_trade_receiving_cards_trade FOREIGN KEY (trade_id) REFERENCES trades(trade_id),
    CONSTRAINT fk_trade_receiving_cards_card FOREIGN KEY (card_id) REFERENCES cards(id)
);
