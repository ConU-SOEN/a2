CREATE TABLE omdb_films (
    omdb_film_id SERIAL PRIMARY KEY,
    swapi_film_id INTEGER,         
    imdb_id VARCHAR(20) UNIQUE,   
    title VARCHAR(255),          
    year VARCHAR(10),              
    ratings JSONB,                
    metascore INTEGER,            
    imdb_rating FLOAT,           
    imdb_votes VARCHAR(50)
);
