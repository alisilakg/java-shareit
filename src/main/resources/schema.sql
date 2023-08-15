
CREATE TABLE IF NOT EXISTS users
(
    id         BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    email      VARCHAR(255)                            NOT NULL,
    user_name  VARCHAR(512)                            NOT NULL,
    CONSTRAINT pk_user PRIMARY KEY (id),
    CONSTRAINT UQ_USER_EMAIL UNIQUE (email)
);

CREATE TABLE IF NOT EXISTS items
(
    id               BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    item_name        VARCHAR(512)                            NOT NULL,
    item_description VARCHAR(255)                            NOT NULL,
    item_available   BOOLEAN,
    owner_id         BIGINT                                  NOT NULL,
    request_id       BIGINT,
    CONSTRAINT pk_item PRIMARY KEY (id),
    CONSTRAINT FK_ITEM_FOR_OWNER FOREIGN KEY (owner_id) REFERENCES users (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS bookings
(
    id         BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    start_time TIMESTAMP WITHOUT TIME ZONE             NOT NULL,
    end_time   TIMESTAMP WITHOUT TIME ZONE             NOT NULL,
    item_id    BIGINT                                  NOT NULL,
    booker_id  BIGINT                                  NOT NULL,
    status     VARCHAR                                 NOT NULL,
    CONSTRAINT PK_BOOKINGS PRIMARY KEY (id),
    CONSTRAINT FK_BOOKING_FOR_ITEM FOREIGN KEY (item_id) REFERENCES items (id) ON DELETE CASCADE,
    CONSTRAINT FK_BOOKING_FOR_BOOKER FOREIGN KEY (booker_id) REFERENCES users (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS comments
(
    id        BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    text      VARCHAR(1024)                           NOT NULL,
    item_id   BIGINT                                  NOT NULL,
    author_id BIGINT                                  NOT NULL,
    created   TIMESTAMP                               NOT NULL,
    CONSTRAINT PK_COMMENTS PRIMARY KEY (id),
    CONSTRAINT FK_COMMENT_FOR_ITEM FOREIGN KEY (item_id) REFERENCES items (id),
    CONSTRAINT FK_COMMENT_FOR_USER FOREIGN KEY (author_id) REFERENCES users (id)
);