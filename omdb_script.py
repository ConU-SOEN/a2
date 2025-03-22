import requests
import psycopg2
import json
from datetime import datetime

# --- Database Connection ---
conn = psycopg2.connect(
    dbname='starwars',
    user='postgres',
    password='password',
    host='localhost',
    port='5432'
)
cur = conn.cursor()

# --- OMDb API Setup ---
OMDB_API_KEY = '14da0c53'
OMDB_BASE_URL = 'http://www.omdbapi.com/'

def fetch_omdb_data(title, year=None):
    """Fetch OMDb data for a given title and optional year."""
    params = {
        'apikey': OMDB_API_KEY,
        't': title
    }
    if year:
        params['y'] = year
    
    response = requests.get(OMDB_BASE_URL, params=params)

    if response.status_code == 200:
        data = response.json()
        if data.get('Response') == 'True':
            return data
        else:
            print(f"No OMDb result for: {title} ({year}) -> {data.get('Error')}")
    else:
        print(f"Request failed for: {title} - Status Code: {response.status_code}")
    
    return None

def insert_omdb_data():
    cur.execute("SELECT film_id, title, release_date FROM swapi_films")
    films = cur.fetchall()

    for film in films:
        film_id, original_title, release_date = film
        year = release_date.year if isinstance(release_date, datetime) else None

        refined_title = refine_title(original_title)

        print(f"Fetching OMDb data for: {refined_title} ({year})")

        omdb_data = fetch_omdb_data(refined_title, year)
        if not omdb_data:
            continue

        imdb_id = omdb_data.get('imdbID')

        # Get year from OMDb if available, fallback to SWAPI year
        omdb_year_str = omdb_data.get('Year')
        omdb_year = int(omdb_year_str) if omdb_year_str and omdb_year_str.isdigit() else year

        ratings = json.dumps(omdb_data.get('Ratings', []))
        metascore = int(omdb_data['Metascore']) if omdb_data.get('Metascore', 'N/A').isdigit() else None
        imdb_rating = float(omdb_data['imdbRating']) if omdb_data.get('imdbRating', 'N/A') != 'N/A' else None
        imdb_votes = omdb_data.get('imdbVotes')

        cur.execute("""
            INSERT INTO omdb_films (
                swapi_film_id, imdb_id, title, year, ratings, metascore, imdb_rating, imdb_votes
            ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
            """, (
            film_id, imdb_id, refined_title, omdb_year, ratings, metascore, imdb_rating, imdb_votes
        ))

        conn.commit()
        print(f"Inserted OMDb data for: {refined_title} ({omdb_year})")


def refine_title(original_title):
    """Map the SWAPI titles to OMDb recognized titles."""
    mapping = {
        "A New Hope": "Star Wars: Episode IV - A New Hope",
        "The Empire Strikes Back": "Star Wars: Episode V - The Empire Strikes Back",
        "Return of the Jedi": "Star Wars: Episode VI - Return of the Jedi",
        "The Phantom Menace": "Star Wars: Episode I - The Phantom Menace",
        "Attack of the Clones": "Star Wars: Episode II - Attack of the Clones",
        "Revenge of the Sith": "Star Wars: Episode III - Revenge of the Sith"
    }
    return mapping.get(original_title, original_title)

def main():
    insert_omdb_data()
    cur.close()
    conn.close()
    print("OMDb data collection complete.")

if __name__ == "__main__":
    main()
