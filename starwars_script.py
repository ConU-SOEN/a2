import requests
import psycopg2

# --- Database Connection Setup ---
conn = psycopg2.connect(
    dbname='starwars',
    user='postgres',
    password='password',
    host='localhost',
    port='5432'
)
cur = conn.cursor()

# --- Helper Function to Fetch Paginated API Results ---
def fetch_all_from_api(endpoint):
    results = []
    url = endpoint
    while url:
        response = requests.get(url)
        if response.status_code == 200:
            data = response.json()
            results.extend(data['results'])
            url = data['next']
        else:
            print(f"Failed to fetch from {url}")
            break
    return results

# --- Inserting Films ---
def insert_films():
    films = fetch_all_from_api('https://swapi.dev/api/films/')
    for film in films:
        cur.execute("""
            INSERT INTO swapi_films (swapi_id, title, episode_id, opening_crawl, director, producer, release_date, created_at, edited_at)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
            """, (
            int(film['url'].split('/')[-2]),   # swapi_id from URL
            film['title'],
            film['episode_id'],
            film['opening_crawl'],
            film['director'],
            film['producer'],
            film['release_date'],
            film['created'],
            film['edited']
        ))
    conn.commit()
    print("Inserted films.")

# --- Inserting People ---
def insert_people():
    people = fetch_all_from_api('https://swapi.dev/api/people/')
    for person in people:
        homeworld_url = person['homeworld']
        homeworld_id = int(homeworld_url.split('/')[-2]) if homeworld_url else None

        cur.execute("""
            INSERT INTO swapi_people (swapi_id, name, height, mass, hair_color, skin_color, eye_color, birth_year, gender, homeworld_id, created_at, edited_at)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
            """, (
            int(person['url'].split('/')[-2]),
            person['name'],
            int(person['height']) if person['height'].isdigit() else None,
            int(person['mass']) if person['mass'].isdigit() else None,
            person['hair_color'],
            person['skin_color'],
            person['eye_color'],
            person['birth_year'],
            person['gender'],
            homeworld_id,
            person['created'],
            person['edited']
        ))
    conn.commit()
    print("Inserted people.")

# --- Inserting Planets ---
def insert_planets():
    planets = fetch_all_from_api('https://swapi.dev/api/planets/')
    for planet in planets:
        cur.execute("""
            INSERT INTO swapi_planets (swapi_id, name, rotation_period, orbital_period, diameter, climate, gravity, terrain, surface_water, population, created_at, edited_at)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
            """, (
            int(planet['url'].split('/')[-2]),
            planet['name'],
            int(planet['rotation_period']) if planet['rotation_period'].isdigit() else None,
            int(planet['orbital_period']) if planet['orbital_period'].isdigit() else None,
            int(planet['diameter']) if planet['diameter'].isdigit() else None,
            planet['climate'],
            planet['gravity'],
            planet['terrain'],
            planet['surface_water'],
            int(planet['population']) if planet['population'].isdigit() else None,
            planet['created'],
            planet['edited']
        ))
    conn.commit()
    print("Inserted planets.")

# --- Inserting Species ---
def insert_species():
    species = fetch_all_from_api('https://swapi.dev/api/species/')
    for specie in species:
        homeworld_url = specie['homeworld']
        homeworld_id = int(homeworld_url.split('/')[-2]) if homeworld_url else None

        cur.execute("""
            INSERT INTO swapi_species (swapi_id, name, classification, designation, average_height, skin_colors, hair_colors, eye_colors, average_lifespan, homeworld_id, language, created_at, edited_at)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
            """, (
            int(specie['url'].split('/')[-2]),
            specie['name'],
            specie['classification'],
            specie['designation'],
            specie['average_height'],
            specie['skin_colors'],
            specie['hair_colors'],
            specie['eye_colors'],
            specie['average_lifespan'],
            homeworld_id,
            specie['language'],
            specie['created'],
            specie['edited']
        ))
    conn.commit()
    print("Inserted species.")

# --- Inserting Vehicles ---
def insert_vehicles():
    vehicles = fetch_all_from_api('https://swapi.dev/api/vehicles/')
    for vehicle in vehicles:
        cur.execute("""
            INSERT INTO swapi_vehicles (swapi_id, name, model, manufacturer, cost_in_credits, length, max_atmosphering_speed, crew, passengers, cargo_capacity, consumables, vehicle_class, created_at, edited_at)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
            """, (
            int(vehicle['url'].split('/')[-2]),
            vehicle['name'],
            vehicle['model'],
            vehicle['manufacturer'],
            int(vehicle['cost_in_credits']) if vehicle['cost_in_credits'].isdigit() else None,
            float(vehicle['length']) if vehicle['length'].replace('.', '', 1).isdigit() else None,
            vehicle['max_atmosphering_speed'],
            vehicle['crew'],
            vehicle['passengers'],
            int(vehicle['cargo_capacity']) if vehicle['cargo_capacity'].isdigit() else None,
            vehicle['consumables'],
            vehicle['vehicle_class'],
            vehicle['created'],
            vehicle['edited']
        ))
    conn.commit()
    print("Inserted vehicles.")

# --- Inserting Starships ---
def insert_starships():
    starships = fetch_all_from_api('https://swapi.dev/api/starships/')
    for starship in starships:
        cur.execute("""
            INSERT INTO swapi_starships (swapi_id, name, model, manufacturer, cost_in_credits, length, max_atmosphering_speed, crew, passengers, cargo_capacity, consumables, hyperdrive_rating, MGLT, starship_class, created_at, edited_at)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
            """, (
            int(starship['url'].split('/')[-2]),
            starship['name'],
            starship['model'],
            starship['manufacturer'],
            int(starship['cost_in_credits']) if starship['cost_in_credits'].isdigit() else None,
            float(starship['length']) if starship['length'].replace('.', '', 1).isdigit() else None,
            starship['max_atmosphering_speed'],
            starship['crew'],
            starship['passengers'],
            int(starship['cargo_capacity']) if starship['cargo_capacity'].isdigit() else None,
            starship['consumables'],
            float(starship['hyperdrive_rating']) if starship['hyperdrive_rating'].replace('.', '', 1).isdigit() else None,
            int(starship['MGLT']) if starship['MGLT'].isdigit() else None,
            starship['starship_class'],
            starship['created'],
            starship['edited']
        ))
    conn.commit()
    print("Inserted starships.")

# --- Main Function ---
def main():
    insert_planets()
    insert_species()
    insert_people()
    insert_films()
    insert_vehicles()
    insert_starships()

    cur.close()
    conn.close()
    print("All data inserted and connection closed.")

if __name__ == "__main__":
    main()
