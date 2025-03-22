-- Table: Films
CREATE TABLE swapi_films (
    film_id SERIAL PRIMARY KEY,
    swapi_id INTEGER UNIQUE,
    title VARCHAR(255),
    episode_id INTEGER,
    opening_crawl TEXT,
    director VARCHAR(255),
    producer VARCHAR(255),
    release_date DATE,
    created_at TIMESTAMP,
    edited_at TIMESTAMP
);

-- Table: People
CREATE TABLE swapi_people (
    person_id SERIAL PRIMARY KEY,
    swapi_id INTEGER UNIQUE,
    name VARCHAR(255),
    height INTEGER,
    mass INTEGER,
    hair_color VARCHAR(100),
    skin_color VARCHAR(100),
    eye_color VARCHAR(100),
    birth_year VARCHAR(20),
    gender VARCHAR(20),
    homeworld_id INTEGER,
    created_at TIMESTAMP,
    edited_at TIMESTAMP
);

-- Table: Planets
CREATE TABLE swapi_planets (
    planet_id SERIAL PRIMARY KEY,
    swapi_id INTEGER UNIQUE,
    name VARCHAR(255),
    rotation_period INTEGER,
    orbital_period INTEGER,
    diameter INTEGER,
    climate VARCHAR(100),
    gravity VARCHAR(100),
    terrain VARCHAR(100),
    surface_water VARCHAR(100),
    population BIGINT,
    created_at TIMESTAMP,
    edited_at TIMESTAMP
);

-- Table: Species
CREATE TABLE swapi_species (
    species_id SERIAL PRIMARY KEY,
    swapi_id INTEGER UNIQUE,
    name VARCHAR(255),
    classification VARCHAR(100),
    designation VARCHAR(100),
    average_height VARCHAR(50),
    skin_colors VARCHAR(255),
    hair_colors VARCHAR(255),
    eye_colors VARCHAR(255),
    average_lifespan VARCHAR(50),
    homeworld_id INTEGER,
    language VARCHAR(100),
    created_at TIMESTAMP,
    edited_at TIMESTAMP
);

-- Table: Vehicles
CREATE TABLE swapi_vehicles (
    vehicle_id SERIAL PRIMARY KEY,
    swapi_id INTEGER UNIQUE,
    name VARCHAR(255),
    model VARCHAR(255),
    manufacturer VARCHAR(255),
    cost_in_credits BIGINT,
    length FLOAT,
    max_atmosphering_speed VARCHAR(50),
    crew VARCHAR(50),
    passengers VARCHAR(50),
    cargo_capacity BIGINT,
    consumables VARCHAR(100),
    vehicle_class VARCHAR(100),
    created_at TIMESTAMP,
    edited_at TIMESTAMP
);

-- Table: Starships
CREATE TABLE swapi_starships (
    starship_id SERIAL PRIMARY KEY,
    swapi_id INTEGER UNIQUE,
    name VARCHAR(255),
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
    starship_class VARCHAR(100),
    created_at TIMESTAMP,
    edited_at TIMESTAMP
);

-- Films ↔ People (characters)
CREATE TABLE swapi_films_people (
    film_id INTEGER REFERENCES swapi_films(film_id),
    person_id INTEGER REFERENCES swapi_people(person_id)
);

-- Films ↔ Planets
CREATE TABLE swapi_films_planets (
    film_id INTEGER REFERENCES swapi_films(film_id),
    planet_id INTEGER REFERENCES swapi_planets(planet_id)
);

-- Films ↔ Starships
CREATE TABLE swapi_films_starships (
    film_id INTEGER REFERENCES swapi_films(film_id),
    starship_id INTEGER REFERENCES swapi_starships(starship_id)
);

-- Films ↔ Vehicles
CREATE TABLE swapi_films_vehicles (
    film_id INTEGER REFERENCES swapi_films(film_id),
    vehicle_id INTEGER REFERENCES swapi_vehicles(vehicle_id)
);

-- Films ↔ Species
CREATE TABLE swapi_films_species (
    film_id INTEGER REFERENCES swapi_films(film_id),
    species_id INTEGER REFERENCES swapi_species(species_id)
);

-- Species ↔ People
CREATE TABLE swapi_species_people (
    species_id INTEGER REFERENCES swapi_species(species_id),
    person_id INTEGER REFERENCES swapi_people(person_id)
);

-- People ↔ Vehicles
CREATE TABLE swapi_people_vehicles (
    person_id INTEGER REFERENCES swapi_people(person_id),
    vehicle_id INTEGER REFERENCES swapi_vehicles(vehicle_id)
);

-- People ↔ Starships
CREATE TABLE swapi_people_starships (
    person_id INTEGER REFERENCES swapi_people(person_id),
    starship_id INTEGER REFERENCES swapi_starships(starship_id)
);
