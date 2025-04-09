import pandas as pd
import psycopg2
import configparser  # for reading configuration information

def load_data(df: pd.DataFrame):
    parser = configparser.ConfigParser()
    parser.read("pipeline.conf")

    dbname = parser.get("postgres_config", "database")
    user = parser.get("postgres_config", "username")
    password = parser.get("postgres_config", "password")
    host = parser.get("postgres_config", "host")
    port = parser.get("postgres_config", "port")

    print(f"Connecting to database {dbname} at {host}:{port} with user {user}")

    conn = psycopg2.connect(
        dbname=dbname,
        user=user,
        password=password,
        host=host,
        port=port
    )
    cursor = conn.cursor()

    # Create dest table (if not exists)
    create_table_query = """
    CREATE TABLE IF NOT EXISTS public.ecustomers (
        order_id INT NULL,
        customer_id INT NULL,
        product_id INT NULL,
        quantity INT NULL,
        price float NULL,
        total_price float NULL,
        name_y VARCHAR(20) NULL,
        location VARCHAR(20) NULL
    );
        """
    cursor.execute(create_table_query)
    conn.commit()


    # Insert data into PostgreSQL table
    for _, row in df.iterrows():
        insert_query = """
        INSERT INTO public.ecustomers (order_id, customer_id, product_id, quantity, price, total_price, name_y, location)
        VALUES (%s, %s, %s, %s, %s, %s, %s,%s);
        """
        cursor.execute(insert_query, (
            row["order_id"], row["customer_id"], row["product_id"], row["quantity"], row["price"],
            row["total_price"], row["name_y"], row["location"]
        ))

    conn.commit()  # Save changes
    cursor.close()
    conn.close()
    print("Data successfully loaded into database!")



