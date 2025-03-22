-- Create Schema for Normalized Data
CREATE SCHEMA normalized;

-- Planets Table (must be created first as it's referenced by others)
CREATE TABLE normalized.planets (
    planet_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    rotation_period INTEGER,
    orbital_period INTEGER,
    diameter INTEGER,
    climate VARCHAR(100),
    gravity VARCHAR(100),
    terrain VARCHAR(100),
    surface_water VARCHAR(100),
    population BIGINT
);

-- Species Table (references planets)
CREATE TABLE normalized.species (
    species_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    classification VARCHAR(100),
    designation VARCHAR(100),
    average_height VARCHAR(50),
    skin_colors VARCHAR(255),
    hair_colors VARCHAR(255),
    eye_colors VARCHAR(255),
    average_lifespan VARCHAR(50),
    homeworld_id INTEGER REFERENCES normalized.planets(planet_id),
    language VARCHAR(100)
);

-- Films Table
CREATE TABLE normalized.films (
    film_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL UNIQUE,
    episode_id INTEGER,
    release_date DATE,
    opening_crawl TEXT,
    director VARCHAR(255),
    producer VARCHAR(255)
);

-- People Table (references planets)
CREATE TABLE normalized.people (
    person_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    height INTEGER,
    mass INTEGER,
    hair_color VARCHAR(100),
    skin_color VARCHAR(100),
    eye_color VARCHAR(100),
    birth_year VARCHAR(20),
    gender VARCHAR(20),
    homeworld_id INTEGER REFERENCES normalized.planets(planet_id)
);

-- Vehicles Table
CREATE TABLE normalized.vehicles (
    vehicle_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    model VARCHAR(255),
    manufacturer VARCHAR(255),
    cost_in_credits BIGINT,
    length FLOAT,
    max_atmosphering_speed VARCHAR(50),
    crew VARCHAR(50),
    passengers VARCHAR(50),
    cargo_capacity BIGINT,
    consumables VARCHAR(100),
    vehicle_class VARCHAR(100)
);

-- Starships Table
CREATE TABLE normalized.starships (
    starship_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    model VARCHAR(255),
    manufacturer VARCHAR(255),
    cost_in_credits BIGINT,
    length FLOAT,
    max_atmosphering_speed VARCHAR(50),
    crew VARCHAR(50),
    passengers VARCHAR(50),
    cargo_capacity BIGINT,
    consumables VARCHAR(100),
    hyperdrive_rating FLOAT,
    MGLT INTEGER,
    starship_class VARCHAR(100)
);

-- Rating Providers (OMDb, Rotten Tomatoes, Metacritic)
CREATE TABLE normalized.rating_providers (
    provider_id SERIAL PRIMARY KEY,
    provider_name VARCHAR(100) UNIQUE
);

-- Ratings Table (links to films and rating providers)
CREATE TABLE normalized.film_ratings (
    rating_id SERIAL PRIMARY KEY,
    film_id INTEGER REFERENCES normalized.films(film_id) ON DELETE CASCADE,
    provider_id INTEGER REFERENCES normalized.rating_providers(provider_id) ON DELETE CASCADE,
    rating_value VARCHAR(20),
    votes VARCHAR(50),
    metascore INTEGER
);

-- Keywords Table (TMDb)
CREATE TABLE normalized.film_keywords (
    keyword_id SERIAL PRIMARY KEY,
    film_id INTEGER REFERENCES normalized.films(film_id) ON DELETE CASCADE,
    keyword VARCHAR(255)
);

-- Films <-> People (Characters in films)
CREATE TABLE normalized.film_people (
    film_id INTEGER REFERENCES normalized.films(film_id) ON DELETE CASCADE,
    person_id INTEGER REFERENCES normalized.people(person_id) ON DELETE CASCADE,
    PRIMARY KEY (film_id, person_id)
);

-- Films <-> Planets
CREATE TABLE normalized.film_planets (
    film_id INTEGER REFERENCES normalized.films(film_id) ON DELETE CASCADE,
    planet_id INTEGER REFERENCES normalized.planets(planet_id) ON DELETE CASCADE,
    PRIMARY KEY (film_id, planet_id)
);

-- Films <-> Starships
CREATE TABLE normalized.film_starships (
    film_id INTEGER REFERENCES normalized.films(film_id) ON DELETE CASCADE,
    starship_id INTEGER REFERENCES normalized.starships(starship_id) ON DELETE CASCADE,
    PRIMARY KEY (film_id, starship_id)
);

-- Films <-> Vehicles
CREATE TABLE normalized.film_vehicles (
    film_id INTEGER REFERENCES normalized.films(film_id) ON DELETE CASCADE,
    vehicle_id INTEGER REFERENCES normalized.vehicles(vehicle_id) ON DELETE CASCADE,
    PRIMARY KEY (film_id, vehicle_id)
);

-- Films <-> Species
CREATE TABLE normalized.film_species (
    film_id INTEGER REFERENCES normalized.films(film_id) ON DELETE CASCADE,
    species_id INTEGER REFERENCES normalized.species(species_id) ON DELETE CASCADE,
    PRIMARY KEY (film_id, species_id)
);

-- People <-> Species (if needed)
CREATE TABLE normalized.person_species (
    person_id INTEGER REFERENCES normalized.people(person_id) ON DELETE CASCADE,
    species_id INTEGER REFERENCES normalized.species(species_id) ON DELETE CASCADE,
    PRIMARY KEY (person_id, species_id)
);

-- People <-> Vehicles
CREATE TABLE normalized.person_vehicles (
    person_id INTEGER REFERENCES normalized.people(person_id) ON DELETE CASCADE,
    vehicle_id INTEGER REFERENCES normalized.vehicles(vehicle_id) ON DELETE CASCADE,
    PRIMARY KEY (person_id, vehicle_id)
);

-- People <-> Starships
CREATE TABLE normalized.person_starships (
    person_id INTEGER REFERENCES normalized.people(person_id) ON DELETE CASCADE,
    starship_id INTEGER REFERENCES normalized.starships(starship_id) ON DELETE CASCADE,
    PRIMARY KEY (person_id, starship_id)
);
