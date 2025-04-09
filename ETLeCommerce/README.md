ETL Pipeline for Ecommerce Data Processing
Overview
This project is an End-to-End ETL (Extract, Transform, Load) Pipeline designed for an ecommerce company. The pipeline extracts data from multiple CSV files, performs data cleaning, merging, and metric calculations, and loads the processed data into a PostgreSQL database for reporting and analysis.

Features
Extracts data from multiple CSV files.

Transforms data by performing:

Data cleaning (handling missing values, formatting inconsistencies, etc.).

Merging datasets based on common keys.

Creating new calculated metrics.

Loads the transformed data into a PostgreSQL database.

Automated pipeline execution with logging.

Technologies Used
Python (ETL scripting)

pandas (Data transformation)

psycopg2 (Database connection)

SQL (Data storage & querying)

Logging (Pipeline monitoring)

Prerequisites
Before running the pipeline, ensure you have the following installed:

Python 3.x

PostgreSQL database

Required Python libraries:

pip install pandas psycopg2 sqlalchemy
Folder Structure
ETL-Pipeline/
│-- data/
│   │-- orders.csv
│   │-- customers.csv
│   │-- products.csv
│-- etl_pipeline.py
│-- pipelineconfig.py
│-- dataconfig.yaml
│-- requirements.txt
│-- README.md
Configuration
Update the pipelineconfig.py file with your PostgreSQL database credentials:

DB_CONFIG = {
    "host": "localhost",
    "database": "ecommerce_db",
    "user": "your_username",
    "password": "your_password",
    "port": 5432
}
How to Run the ETL Pipeline
Ensure your PostgreSQL database is running and properly configured.

Place all input CSV files inside the data/ directory.

Run the ETL script:

python etl_pipeline.py
Verify that the data has been loaded into PostgreSQL using:

SELECT * FROM transformed_table;