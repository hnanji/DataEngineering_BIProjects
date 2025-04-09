import pandas as pd
import psycopg2
import configparser  # for reading configuration information

def load_data(df1: object, df2: object, df3: object,df4: object,df5: object,df6: object) -> object:
    parser = configparser.ConfigParser()
    parser.read("pipeline.conf")

    df1 = df1
    df2 = df2
    df3 = df3
    df4 = df4
    df5 = df5
    df6 = df6

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
    create_table_query1 = """
    CREATE TABLE IF NOT EXISTS public.sales202004(
        Retailer VARCHAR(20) NULL,
        SkuCode	 INT NULL,
        Product VARCHAR(20) NULL,
        SalesMonth DATE NOT NULL,
        SalesValue float NULL,
        UnitsSold INT NULL
    );
        """
    cursor.execute(create_table_query1)
    conn.commit()


    # Insert data into PostgreSQL table
    for _, row in df1.iterrows():
        insert_query1 = """
        INSERT INTO public.sales202004 (Retailer, SkuCode, Product, SalesMonth,  SalesValue, UnitsSold)
        VALUES (%s, %s, %s, %s, %s, %s);
        """
        cursor.execute(insert_query1, (
            row["Retailer"], row["SkuCode"], row["Product"], row["SalesMonth"], row["SalesValue"],
            row["UnitsSold"]
        ))

    conn.commit()  # Save changes
    #cursor.close()
    #conn.close()
    print("2020-04 Data successfully loaded into database!")

    # Create dest table (if not exists)
    create_table_query2 = """
    CREATE TABLE IF NOT EXISTS public.sales202005(
        Retailer VARCHAR(20) NULL,
        SkuCode	 INT NULL,
        Product VARCHAR(20) NULL,
        SalesMonth DATE NOT NULL,
        SalesValue float NULL,
        UnitsSold INT NULL
    );
        """
    cursor.execute(create_table_query2)
    conn.commit()


    # Insert data into PostgreSQL table
    for _, row in df2.iterrows():
        insert_query2 = """
        INSERT INTO public.sales202005 (Retailer, SkuCode, Product, SalesMonth,  SalesValue, UnitsSold)
        VALUES (%s, %s, %s, %s, %s, %s);
        """
        cursor.execute(insert_query2, (
            row["Retailer"], row["SkuCode"], row["Product"], row["SalesMonth"], row["SalesValue"],
            row["UnitsSold"]
        ))

    conn.commit()  # Save changes
    #cursor.close()
    #conn.close()
    print("2020-05 Data successfully loaded into database!")

    ##
        # Create dest table (if not exists)
    create_table_query3 = """
    CREATE TABLE IF NOT EXISTS public.sales202006(
        Retailer VARCHAR(20) NULL,
        SkuCode	 INT NULL,
        Product VARCHAR(20) NULL,
        SalesMonth DATE NOT NULL,
        SalesValue float NULL,
        UnitsSold INT NULL
    );
        """
    cursor.execute(create_table_query3)
    conn.commit()


    # Insert data into PostgreSQL table
    for _, row in df3.iterrows():
        insert_query3 = """
        INSERT INTO public.sales202006 (Retailer, SkuCode, Product, SalesMonth,  SalesValue, UnitsSold)
        VALUES (%s, %s, %s, %s, %s, %s);
        """
        cursor.execute(insert_query3, (
            row["Retailer"], row["SkuCode"], row["Product"], row["SalesMonth"], row["SalesValue"],
            row["UnitsSold"]
        ))

    conn.commit()  # Save changes
    #cursor.close()
   #conn.close()
    print("2020-06 Data successfully loaded into database!")

    ##
        # Create dest table (if not exists)
    create_table_query4 = """
    CREATE TABLE IF NOT EXISTS public.sales202007(
        Retailer VARCHAR(20) NULL,
        SkuCode	 INT NULL,
        Product VARCHAR(20) NULL,
        SalesMonth DATE NOT NULL,
        SalesValue float NULL,
        UnitsSold INT NULL
    );
        """
    cursor.execute(create_table_query4)
    conn.commit()


    # Insert data into PostgreSQL table
    for _, row in df4.iterrows():
        insert_query4 = """
        INSERT INTO public.sales202007 (Retailer, SkuCode, Product, SalesMonth,  SalesValue, UnitsSold)
        VALUES (%s, %s, %s, %s, %s, %s);
        """
        cursor.execute(insert_query4, (
            row["Retailer"], row["SkuCode"], row["Product"], row["SalesMonth"], row["SalesValue"],
            row["UnitsSold"]
        ))

    conn.commit()  # Save changes
    #cursor.close()
    #conn.close()
    print("2020-07 Data successfully loaded into database!")

    ##
        # Create dest table (if not exists)
    create_table_query5 = """
    CREATE TABLE IF NOT EXISTS public.sales202008(
        Retailer VARCHAR(20) NULL,
        SkuCode	 INT NULL,
        Product VARCHAR(20) NULL,
        SalesMonth DATE NOT NULL,
        SalesValue float NULL,
        UnitsSold INT NULL
    );
        """
    cursor.execute(create_table_query5)
    conn.commit()


    # Insert data into PostgreSQL table
    for _, row in df5.iterrows():
        insert_query5 = """
        INSERT INTO public.sales202008 (Retailer, SkuCode, Product, SalesMonth,  SalesValue, UnitsSold)
        VALUES (%s, %s, %s, %s, %s, %s);
        """
        cursor.execute(insert_query5, (
            row["Retailer"], row["SkuCode"], row["Product"], row["SalesMonth"], row["SalesValue"],
            row["UnitsSold"]
        ))

    conn.commit()  # Save changes
    #cursor.close()
    #conn.close()
    print("2020-08 Data successfully loaded into database!")
    ##
        # Create dest table (if not exists)
    create_table_query6 = """
    CREATE TABLE IF NOT EXISTS public.sales202009(
        Retailer VARCHAR(20) NULL,
        SkuCode	 INT NULL,
        Product VARCHAR(20) NULL,
        SalesMonth DATE NOT NULL,
        SalesValue float NULL,
        UnitsSold INT NULL
    );
        """
    cursor.execute(create_table_query6)
    conn.commit()


    # Insert data into PostgreSQL table
    for _, row in df6.iterrows():
        insert_query6 = """
        INSERT INTO public.sales202009 (Retailer, SkuCode, Product, SalesMonth,  SalesValue, UnitsSold)
        VALUES (%s, %s, %s, %s, %s, %s);
        """
        cursor.execute(insert_query6, (
            row["Retailer"], row["SkuCode"], row["Product"], row["SalesMonth"], row["SalesValue"],
            row["UnitsSold"]
        ))

    conn.commit()  # Save changes
    cursor.close()
    conn.close()
    print("2020-09 Data successfully loaded into database!")


