CREATE TABLE user_completed_collections (
    user_id       INT NOT NULL,
    collection_id INT NOT NULL,
    PRIMARY KEY (user_id, collection_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (collection_id) REFERENCES collections(collection_id)
);