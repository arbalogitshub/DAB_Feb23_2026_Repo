-- Created Tables for SQL Online Music Store 
-- Create artists table
CREATE TABLE IF NOT EXISTS artists
(
    artist_id      INTEGER NOT NULL, 
    artist_name    TEXT,
    genre          TEXT,
    country        TEXT,
    active_since   TEXT,    -- YYYY-MM-DD format
    
    CONSTRAINT pk_artist PRIMARY KEY (artist_id)
);

  -- Create songs table   
CREATE TABLE IF NOT EXISTS songs
(
    song_id          INTEGER NOT NULL,
    title            TEXT,
    artist_id        INTEGER NOT NULL,
    album            TEXT,
    release_date     TEXT,    -- YYYY-MM-DD format
    duration_seconds INTEGER,
    popularity_score INTEGER CHECK (popularity_score BETWEEN 0 AND 100),
    
    CONSTRAINT pk_song_id PRIMARY KEY (song_id),
    CONSTRAINT fk_artist_id FOREIGN KEY (artist_id) REFERENCES artists (artist_id)
ON DELETE CASCADE
);

-- Create customers table 
CREATE TABLE IF NOT EXISTS customers
(
    customer_id INTEGER NOT NULL,
    first_name TEXT,
    last_name   TEXT,
    email    TEXT UNIQUE,
    join_date   TEXT,    -- YYYY-MM-DD format
    premium_member    INTEGER NOT NULL DEFAULT 0, -- on scale of 0-1 
    
    CONSTRAINT pk_customer_id PRIMARY KEY (customer_id)
);

-- Create purchases table
CREATE TABLE IF NOT EXISTS purchases
(
    purchase_id    INTEGER NOT NULL,
    customer_id    INTEGER NOT NULL,
    song_id        INTEGER NOT NULL,
    purchase_date    TEXT,    -- YYYY-MM-DD format 
    price            NUMERIC(10,2) CHECK (price>=0),
    
    CONSTRAINT pk_purchase_id PRIMARY KEY (purchase_id),
    CONSTRAINT fk_purchase_customer  FOREIGN KEY (customer_id)  REFERENCES customers(customer_id)
    CONSTRAINT fk_purchase_song FOREIGN KEY (song_id) REFERENCES songs(song_id)
);

CREATE TABLE IF NOT EXISTS streams
( 
    stream_id     INTEGER NOT NULL,
    customer_id   INTEGER NOT NULL,
    song_id    INTEGER NOT NULL,
    stream_date    TEXT,    -- YYYY-MM-DD format
    stream_time    TEXT,    -- HH:MM:SS format
    
    CONSTRAINT pk_stream_id PRIMARY KEY (stream_id),
    CONSTRAINT fk_stream_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_stream_song FOREIGN KEY (song_id) REFERENCES songs(song_id)
);

-- Review artists data (5 columns, 15 rows) 
SELECT * FROM artists;

-- Review songs data (7 columns, 40 rows)
SELECT * FROM songs;

-- Review customers data ( 6 columns, 20 rows)
SELECT * FROM customers;

-- Review purchases data (5 columns, 40 rows) 
SELECT * FROM purchases;

-- Review streams (5 columns, 70 rows )
SELECT * FROM streams;
