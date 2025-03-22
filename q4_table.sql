CREATE TABLE tmdb_starwars_popularity (
    tmdb_movie_id BIGINT PRIMARY KEY,
    title VARCHAR(255),
    popularity FLOAT
);

CREATE TABLE tmdb_starwars_keywords (
    keyword_id BIGINT PRIMARY KEY,
    tmdb_movie_id BIGINT,
    keyword VARCHAR(255),
    FOREIGN KEY (tmdb_movie_id) REFERENCES tmdb_starwars_popularity(tmdb_movie_id)
);
