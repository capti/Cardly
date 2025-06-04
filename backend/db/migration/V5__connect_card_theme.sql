ALTER TABLE cards
    ADD COLUMN theme_id INT;

ALTER TABLE cards
    ADD CONSTRAINT fk_cards_theme
    FOREIGN KEY (theme_id)
    REFERENCES themes(theme_id);

ALTER TABLE cards
    DROP COLUMN theme;
