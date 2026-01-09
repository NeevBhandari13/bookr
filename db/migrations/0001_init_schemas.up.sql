CREATE EXTENSION IF NOT EXISTS btree_gist;

CREATE TABLE users (
    id SERIAL PRIMARY KEY NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email_address VARCHAR(50) NOT NULL UNIQUE,
    phone_number VARCHAR(12) NOT NULL UNIQUE,
    user_role VARCHAR(10) NOT NULL
    CHECK (user_role IN ('player', 'admin'))
);

CREATE TABLE venues (
    id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR(50) NOT NULL,
    address VARCHAR(100) NOT NULL UNIQUE,
    email_address VARCHAR(50) NOT NULL UNIQUE,
    phone_number VARCHAR(12) NOT NULL UNIQUE
);

CREATE TABLE courts (
    id SERIAL PRIMARY KEY NOT NULL,
    venue_id INT NOT NULL REFERENCES venues(id),
    court_number INT NOT NULL,
    UNIQUE (venue_id, court_number),
    court_type VARCHAR(50) NOT NULL
);

CREATE TABLE bookings (
    id SERIAL PRIMARY KEY NOT NULL,
    user_id INT NOT NULL REFERENCES users(id),
    court_id INT NOT NULL REFERENCES courts(id),
    start_time TIMESTAMPTZ NOT NULL,
    end_time TIMESTAMPTZ NOT NULL,
    CHECK (end_time > start_time),
    -- allows us to check for overlaps in booking times with gist and for the same court id using b_trees
    EXCLUDE USING gist (
        court_id WITH =,
        tstzrange(start_time, end_time) WITH &&
    )
);




