-- Insert planets
INSERT INTO normalized.planets (planet_id, name, rotation_period, orbital_period, diameter, climate, gravity, terrain, surface_water, population)
SELECT planet_id, name, rotation_period, orbital_period, diameter, climate, gravity, terrain, surface_water, population
FROM swapi_planets
ON CONFLICT (planet_id) DO NOTHING;


-- Insert species
INSERT INTO normalized.species (species_id, name, classification, designation, average_height, skin_colors, hair_colors, eye_colors, average_lifespan, homeworld_id, language)
SELECT species_id, name, classification, designation, average_height, skin_colors, hair_colors, eye_colors, average_lifespan, homeworld_id, language
FROM swapi_species
ON CONFLICT (species_id) DO NOTHING;


-- Insert films
INSERT INTO normalized.films (film_id, title, episode_id, release_date, opening_crawl, director, producer)
SELECT film_id, title, episode_id, release_date, opening_crawl, director, producer
FROM swapi_films
ON CONFLICT (film_id) DO NOTHING;


-- Insert people
INSERT INTO normalized.people (person_id, name, height, mass, hair_color, skin_color, eye_color, birth_year, gender, homeworld_id)
SELECT person_id, name, height, mass, hair_color, skin_color, eye_color, birth_year, gender, homeworld_id
FROM swapi_people
ON CONFLICT (person_id) DO NOTHING;


-- Insert vehicles
INSERT INTO normalized.vehicles (vehicle_id, name, model, manufacturer, cost_in_credits, length, max_atmosphering_speed, crew, passengers, cargo_capacity, consumables, vehicle_class)
SELECT vehicle_id, name, model, manufacturer, cost_in_credits, length, max_atmosphering_speed, crew, passengers, cargo_capacity, consumables, vehicle_class
FROM swapi_vehicles
ON CONFLICT (vehicle_id) DO NOTHING;

-- Insert starships
INSERT INTO normalized.starships (starship_id, name, model, manufacturer, cost_in_credits, length, max_atmosphering_speed, crew, passengers, cargo_capacity, consumables, hyperdrive_rating, MGLT, starship_class)
SELECT starship_id, name, model, manufacturer, cost_in_credits, length, max_atmosphering_speed, crew, passengers, cargo_capacity, consumables, hyperdrive_rating, MGLT, starship_class
FROM swapi_starships
ON CONFLICT (starship_id) DO NOTHING;


-- Insert rating providers (IMDB, Rotten Tomatoes, etc.)
INSERT INTO normalized.rating_providers (provider_name)
VALUES 
('IMDB'),
('Rotten Tomatoes'),
('Metacritic')
ON CONFLICT (provider_name) DO NOTHING;


-- Insert film ratings (from omdb_films and rating_providers)
INSERT INTO normalized.film_ratings (film_id, provider_id, rating_value, votes, metascore)
SELECT sw.film_id, 
       rp.provider_id, 
       r.rating->>'Value' AS rating_value,  -- Rating value
       r.rating->>'Votes' AS votes,         -- Votes
       f.metascore
FROM omdb_films f
JOIN swapi_films sw
    ON f.swapi_film_id = sw.film_id  -- Join on swapi_film_id (from omdb_films) to swapi_films.film_id
JOIN normalized.rating_providers rp
    ON rp.provider_name = 'IMDB'  -- Example for IMDB, adjust this for others (e.g., Rotten Tomatoes)
JOIN LATERAL jsonb_array_elements(f.ratings) AS r (rating) 
    ON r.rating->>'Source' = rp.provider_name  -- Ensure the correct source (e.g., 'IMDB')
WHERE f.swapi_film_id IS NOT NULL
ON CONFLICT (rating_id) DO NOTHING;


-- Insert keywords

ALTER TABLE normalized.film_keywords
ADD CONSTRAINT unique_film_keyword UNIQUE (film_id, keyword);

INSERT INTO normalized.film_keywords (film_id, keyword)
SELECT f.film_id, k.keyword
FROM swapi_films f
JOIN tmdb_starwars_keywords k ON f.film_id = k.tmdb_movie_id
ON CONFLICT (film_id, keyword) DO NOTHING;


-- Insert film_people relationships
INSERT INTO normalized.film_people (film_id, person_id)
SELECT f.film_id, p.person_id
FROM swapi_films f
JOIN swapi_films_people fp ON f.film_id = fp.film_id  -- Join swapi_films_people to get the correct relationship
JOIN swapi_people p ON p.person_id = fp.person_id
ON CONFLICT (film_id, person_id) DO NOTHING;


-- Insert film_planets relationships
INSERT INTO normalized.film_planets (film_id, planet_id)
SELECT f.film_id, p.planet_id
FROM swapi_films f
JOIN swapi_films_planets fp ON f.film_id = fp.film_id  -- Join swapi_films_planets to get the correct relationship
JOIN swapi_planets p ON p.planet_id = fp.planet_id
ON CONFLICT (film_id, planet_id) DO NOTHING;


-- Insert film_starships relationships
INSERT INTO normalized.film_starships (film_id, starship_id)
SELECT f.film_id, s.starship_id
FROM swapi_films f
JOIN swapi_films_starships fs ON f.film_id = fs.film_id  -- Join swapi_films_starships to get the correct relationship
JOIN swapi_starships s ON s.starship_id = fs.starship_id
ON CONFLICT (film_id, starship_id) DO NOTHING;


-- Insert film_vehicles relationships
INSERT INTO normalized.film_vehicles (film_id, vehicle_id)
SELECT f.film_id, v.vehicle_id
FROM swapi_films f
JOIN swapi_films_vehicles fv ON f.film_id = fv.film_id  -- Join swapi_films_vehicles to get the correct relationship
JOIN swapi_vehicles v ON v.vehicle_id = fv.vehicle_id
ON CONFLICT (film_id, vehicle_id) DO NOTHING;


-- Insert film_species relationships
INSERT INTO normalized.film_species (film_id, species_id)
SELECT f.film_id, s.species_id
FROM swapi_films f
JOIN swapi_films_species fs ON f.film_id = fs.film_id  -- Join swapi_films_species to get the correct relationship
JOIN swapi_species s ON s.species_id = fs.species_id
ON CONFLICT (film_id, species_id) DO NOTHING;


-- Insert person_species relationships
INSERT INTO normalized.person_species (person_id, species_id)
SELECT p.person_id, s.species_id
FROM swapi_people p
JOIN swapi_people_species ps ON p.person_id = ps.person_id  -- Join swapi_people_species to get the correct relationship
JOIN swapi_species s ON s.species_id = ps.species_id
ON CONFLICT (person_id, species_id) DO NOTHING;
