-- Inserting Data into swapi_films
INSERT INTO swapi_films (swapi_id, title, episode_id, opening_crawl, director, producer, release_date, created_at, edited_at)
VALUES 
(1, 'A New Hope', 4, 'It is a period of civil war...', 'George Lucas', 'George Lucas', '1977-05-25', '2014-12-10T14:23:21.253Z', '2014-12-10T14:23:21.253Z'),
(2, 'The Empire Strikes Back', 5, 'It is a dark time for the Rebellion...', 'Irvin Kershner', 'George Lucas', '1980-05-17', '2014-12-10T14:23:21.253Z', '2014-12-10T14:23:21.253Z'),
(3, 'Return of the Jedi', 6, 'Luke Skywalker has returned to his home planet...', 'Richard Marquand', 'George Lucas', '1983-05-25', '2014-12-10T14:23:21.253Z', '2014-12-10T14:23:21.253Z'),
(4, 'The Phantom Menace', 1, 'Turmoil has engulfed the Galactic Republic...', 'George Lucas', 'George Lucas', '1999-05-19', '2014-12-10T14:23:21.253Z', '2014-12-10T14:23:21.253Z'),
(5, 'Attack of the Clones', 2, 'There is unrest in the Galactic Senate...', 'George Lucas', 'George Lucas', '2002-05-16', '2014-12-10T14:23:21.253Z', '2014-12-10T14:23:21.253Z'),
(6, 'Revenge of the Sith', 3, 'War! The Republic is crumbling under attacks...', 'George Lucas', 'George Lucas', '2005-05-19', '2014-12-10T14:23:21.253Z', '2014-12-10T14:23:21.253Z');

-- Inserting Data into swapi_people
INSERT INTO swapi_people (swapi_id, name, height, mass, hair_color, skin_color, eye_color, birth_year, gender, homeworld_id, created_at, edited_at)
VALUES
(1, 'Luke Skywalker', 172, 77, 'blond', 'fair', 'blue', '19BBY', 'male', 1, '2014-12-10T14:23:21.253Z', '2014-12-10T14:23:21.253Z'),
(2, 'C-3PO', 167, 75, 'gold', 'gold', 'yellow', '112BBY', 'n/a', 1, '2014-12-10T14:23:21.253Z', '2014-12-10T14:23:21.253Z'),
(3, 'R2-D2', 96, 32, 'white', 'blue', 'red', '33BBY', 'n/a', 1, '2014-12-10T14:23:21.253Z', '2014-12-10T14:23:21.253Z'),
(4, 'Darth Vader', 202, 136, 'none', 'white', 'yellow', '41.9BBY', 'male', 2, '2014-12-10T14:23:21.253Z', '2014-12-10T14:23:21.253Z');

-- Inserting Data into swapi_planets
INSERT INTO swapi_planets (swapi_id, name, rotation_period, orbital_period, diameter, climate, gravity, terrain, surface_water, population, created_at, edited_at)
VALUES
(1, 'Tatooine', 23, 304, 10465, 'arid', '1', 'desert', '1', 200000, '2014-12-10T14:23:21.253Z', '2014-12-10T14:23:21.253Z'),
(2, 'Alderaan', 24, 364, 12500, 'temperate', '1', 'grasslands, mountains', '1', 2000000, '2014-12-10T14:23:21.253Z', '2014-12-10T14:23:21.253Z');

-- Inserting Data into swapi_species
INSERT INTO swapi_species (swapi_id, name, classification, designation, average_height, skin_colors, hair_colors, eye_colors, average_lifespan, homeworld_id, language, created_at, edited_at)
VALUES
(1, 'Human', 'mammal', 'sentient', '172', 'fair', 'brown', 'blue', '120', 1, 'galactic basic', '2014-12-10T14:23:21.253Z', '2014-12-10T14:23:21.253Z'),
(2, 'Droid', 'artificial', 'sentient', 'n/a', 'metal', 'n/a', 'n/a', 'indefinite', 1, 'basic', '2014-12-10T14:23:21.253Z', '2014-12-10T14:23:21.253Z');

-- Inserting Data into swapi_vehicles
INSERT INTO swapi_vehicles (swapi_id, name, model, manufacturer, cost_in_credits, length, max_atmosphering_speed, crew, passengers, cargo_capacity, consumables, vehicle_class, created_at, edited_at)
VALUES
(4, 'Sand Crawler', 'Digger Crawler', 'Corellia Mining Corporation', 150000, 36.8, 30, 5, 30, 50000, '2 months', 'wheeled', '2014-12-10T14:23:21.253Z', '2014-12-10T14:23:21.253Z');

-- Inserting Data into swapi_starships
INSERT INTO swapi_starships (swapi_id, name, model, manufacturer, cost_in_credits, length, max_atmosphering_speed, crew, passengers, cargo_capacity, consumables, hyperdrive_rating, MGLT, starship_class, created_at, edited_at)
VALUES
(5, 'CR90 corvette', 'CR90 corvette', 'Corellian Engineering Corporation', 3500000, 150, 950, 30, 600, 300000, '1 year', 1.0, 60, 'corvette', '2014-12-10T14:23:21.253Z', '2014-12-10T14:23:21.253Z');
