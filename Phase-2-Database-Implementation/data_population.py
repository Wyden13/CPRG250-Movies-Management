import psycopg2

def populate_database():
    conn = psycopg2.connect(
        # host="localhost",
        database="moviedb",
        user="postgres",
        password="Uyen132004@",
        host="127.0.0.1",
        port=5432
    )
    cur = conn.cursor()
    # Delete all the data
    truncate_tables = f"""
    TRUNCATE MovieAdvisory, MovieDirector, MovieCategory, MovieActor, Wishlist, Rental, Customer, Movie, Advisory, Director, Category, Actor CASCADE;
    """
    cur.execute(truncate_tables)
    conn.commit()
    
    pathntable = {'sample-data\\actors.csv':'actor', 
                'sample-data\\movies.csv':'movie', 
                'sample-data\\advisories.csv':'advisory',
                'sample-data\\ShawVOD_Categories.csv':'category',
                'sample-data\\directors.csv':'director',
                'sample-data\\customers.csv':'customer',
                'sample-data\\rentals.csv' :'rental',
                'sample-data\\wishlists.csv':'wishlist',

                }
    for path, table in pathntable.items():
        copy_sql = f"""
            COPY {table} FROM STDIN WITH CSV
        """
        with open(path, 'r') as f:
            next(f)  # Skip header row
            cur.copy_expert(copy_sql, f)
        conn.commit()

    # Child tables
    pathntable_child = {'sample-data\\bridges\\MovieCategory_Links.csv':'moviecategory', 
                    'sample-data\\bridges\\MovieActor_Links.csv':'movieactor',
                    'sample-data\\bridges\\MovieAdvisory_Links.csv':'movieadvisory',
                    'sample-data\\bridges\\MovieDirector_Links.csv':'moviedirector'}
    for path, table in pathntable_child.items():
        copy_sql = f"""
            COPY {table} FROM STDIN WITH CSV
        """
        with open(path, 'r') as f:
            next(f)  # Skip header row
            cur.copy_expert(copy_sql, f)
        conn.commit()
    print("Database populated successfully.")
    conn.close()

if __name__ == "__main__":
    # db_config = {"user": "postgres", "password": "Uyen132004@", "host": "127.0.0.1", "port": 5432}
    populate_database()