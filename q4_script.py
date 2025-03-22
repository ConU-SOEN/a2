import pandas as pd
import psycopg2

# --- Database Connection ---
conn = psycopg2.connect(
    dbname='starwars',
    user='postgres',
    password='password',  # Your actual password
    host='localhost',
    port='5432'
)
cur = conn.cursor()

# --- Load TMDB Dataset ---
tmdb_df = pd.read_csv('TMDB_movie_dataset_v11.csv')

# --- Filter Star Wars Movies ---
star_wars_titles = [
    "A New Hope",
    "The Empire Strikes Back",
    "Return of the Jedi",
    "The Phantom Menace",
    "Attack of the Clones",
    "Revenge of the Sith"
]

# Clean title column to match search criteria
tmdb_df['clean_title'] = tmdb_df['title'].str.strip()

star_wars_movies = tmdb_df[tmdb_df['clean_title'].isin(star_wars_titles)]

print(f"Found {len(star_wars_movies)} Star Wars movies in the dataset.")
print(star_wars_movies[['title', 'clean_title', 'keywords']])

# --- Insert into tmdb_starwars_popularity ---
print("Inserting into tmdb_starwars_popularity...")

for _, row in star_wars_movies.iterrows():
    tmdb_movie_id = int(row['id'])
    title = row['title']
    popularity = float(row['popularity']) if pd.notnull(row['popularity']) else None

    cur.execute("""
        INSERT INTO tmdb_starwars_popularity (tmdb_movie_id, title, popularity)
        VALUES (%s, %s, %s)
        ON CONFLICT (tmdb_movie_id) DO NOTHING
    """, (tmdb_movie_id, title, popularity))

conn.commit()
print("✅ Inserted Star Wars Popularity Data.")

# --- Insert into tmdb_starwars_keywords ---
print("Inserting into tmdb_starwars_keywords...")

for _, row in star_wars_movies.iterrows():
    tmdb_movie_id = int(row['id'])
    keywords_text = row['keywords']

    if pd.isna(keywords_text) or keywords_text.strip() == '':
        print(f"⚠️ Skipping empty keywords for movie: {row['title']}")
        continue

    # Split by comma, strip spaces
    keywords_list = [kw.strip() for kw in keywords_text.split(',') if kw.strip() != '']

    # Insert each keyword into the table
    for keyword_name in keywords_list:
        cur.execute("""
            INSERT INTO tmdb_starwars_keywords (tmdb_movie_id, keyword)
            VALUES (%s, %s)
        """, (tmdb_movie_id, keyword_name))

conn.commit()
print("✅ Inserted Star Wars Keywords Data.")

# --- Close the Connection ---
cur.close()
conn.close()
print("✅ All Done! PostgreSQL connection closed.")
