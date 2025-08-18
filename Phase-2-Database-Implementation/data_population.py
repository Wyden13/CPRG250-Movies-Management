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
    # # Delete all the data
    truncate_tables = f"""
    TRUNCATE Movie_Advisory, Movie_Director, Movie_Category, Movie_Actor, Wishlist, Rental, Customer, Movie, Advisory, Director, Category, Actor CASCADE;
    """
    cur.execute(truncate_tables)
    conn.commit()
    
    pathntable = {'sample-data\\actors.csv':'actor', 
                'sample-data\\movies.csv':'movie', 
                'sample-data\\advisories.csv':'advisory',
                'sample-data\\categories.csv':'category',
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
    pathntable_child = {'sample-data\\bridges\\Movie_Category.csv':'Movie_Category', 
                    'sample-data\\bridges\\Movie_Actor.csv':'Movie_Actor',
                    'sample-data\\bridges\\Movie_Advisory.csv':'Movie_Advisory',
                    'sample-data\\bridges\\Movie_Director.csv':'Movie_Director'}
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