-- 9.1 Find the total number of movies, total number of planets, total number of people in the database. Use one query.
-- This query counts the number of movies, planets, and people in the database

SELECT 
    (SELECT COUNT(*) FROM swapi_films) AS total_movies,
    (SELECT COUNT(*) FROM swapi_planets) AS total_planets,
    (SELECT COUNT(*) FROM swapi_people) AS total_people;

-- 9.2 Find top 3 movies with the highest number of keywords.
-- This query finds the top 3 movies with the highest count of keywords associated with them.

SELECT 
    swapi_films.title, 
    COUNT(tmdb_starwars_keywords.keyword) AS keyword_count
FROM 
    swapi_films
JOIN 
    tmdb_starwars_keywords 
    ON swapi_films.film_id = tmdb_starwars_keywords.tmdb_movie_id
GROUP BY 
    swapi_films.film_id
ORDER BY 
    keyword_count DESC
LIMIT 3;

-- 9.3 Find popular keyword(s) and movies associated with them.
-- This query retrieves popular keywords and the movies they are associated with, ordered by the frequency of the keyword.

SELECT 
    tmdb_starwars_keywords.keyword,
    swapi_films.title,
    COUNT(tmdb_starwars_keywords.keyword) AS keyword_count
FROM 
    tmdb_starwars_keywords
JOIN 
    swapi_films 
    ON tmdb_starwars_keywords.tmdb_movie_id = swapi_films.film_id
GROUP BY 
    tmdb_starwars_keywords.keyword, swapi_films.title
ORDER BY 
    keyword_count DESC;

-- 9.4 Find top ranked movies for each rating provider.
-- This query finds the top-ranked movies for each rating provider by sorting them based on the rating value.

SELECT 
    rp.provider_name,
    f.title,
    fr.rating_value
FROM 
    normalized.film_ratings fr
JOIN 
    swapi_films f 
    ON fr.film_id = f.film_id
JOIN 
    normalized.rating_providers rp 
    ON fr.provider_id = rp.provider_id
WHERE 
    fr.rating_value IS NOT NULL
ORDER BY 
    rp.provider_name, CAST(fr.rating_value AS FLOAT) DESC;

-- 9.5 Write a batch-update query that rounds up all the ratings.
-- This query updates the ratings by rounding up each value to the nearest integer.

UPDATE normalized.film_ratings
SET rating_value = CEIL(CAST(rating_value AS FLOAT))
WHERE rating_value IS NOT NULL AND rating_value != '';
