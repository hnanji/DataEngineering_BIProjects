Business Intelligence Project: Sales Analysis for an Online Candy Shop

Overview

This Business Intelligence (BI) project aims to analyze the sales performance of an online candy shop. The insights derived from this analysis will help identify top-selling products, revenue trends, and sales patterns, allowing for informed decision-making to optimize business strategies.

Objectives

Identify the top-selling products based on sales volume and revenue.

Analyze revenue trends over different time periods.

Detect seasonal sales patterns and peak demand periods.

Evaluate sales performance by product category and retailer.

Provide actionable insights for business growth.

Data Sources

The project utilizes sales data from multiple months, including:

Retailer information

Product details

Sales month

Sales value

Units sold

Tools & Technologies

The following tools and technologies are used in this project:

Python (for data extraction, transformation, and analysis)

Pandas (for data manipulation)

PostgreSQL (for database storage and querying)

Excel/CSV files (for data input and reporting)

Power BI/Tableau (for data visualization and dashboards)

Prerequisites
Before running the pipeline, ensure you have the following installed:

Python 3.x

PostgreSQL database

Required Python libraries:

pip install pandas psycopg2 sqlalchemy

Folder Structure
ETL-Pipeline/
│-- data/
│   │-- 2020-04.csv
    │-- 2020-05.csv
    │-- 2020-06.csv
    │-- 2020-07.csv
    │-- 2020-08.csv
    │-- 2020-09.csv
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