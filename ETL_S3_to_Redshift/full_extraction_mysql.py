#import pymysql
import pyodbc 
import csv
import boto3
import configparser
import os

# Read configuration
parser = configparser.ConfigParser()
parser.read("pipeline.conf")

hostname = parser.get("sql_config", "hostname")
dbname = parser.get("sql_config", "database")
trusted_connection = parser.get("sql_config", "Trusted_Connection")
driver = parser.get("sql_config", "driver")

# Connection string
conn_str = f"DRIVER={driver};SERVER={hostname};DATABASE={dbname};Trusted_Connection={trusted_connection}"

# Establish connection
try:
    conn = pyodbc.connect(conn_str)
    print("SQL Server connection established!")
except pyodbc.Error as e:
    print("Error connecting to SQL Server:", e)
    exit()

m_cursor = conn.cursor()

# Define the directory and ensure it exists
#directory = "data"
#os.makedirs(directory, exist_ok=True)

def export_to_csv(query, filename):
    """Executes a SQL query and exports the results to a CSV file with column headers."""
    m_cursor.execute(query)
    results = m_cursor.fetchall()
    
    # Extract column names
    column_names = [desc[0] for desc in m_cursor.description]

    with open(filename, 'w', newline='') as fp:
        csv_w = csv.writer(fp, delimiter=',')
        
        # Write column headers
        csv_w.writerow(column_names)
        
        # Write data rows
        csv_w.writerows(results)

    print(f"Data successfully saved to {filename}")

# Sales query
sales_query = """
    SELECT [SalesOrderID], [CustomerID], [SalesPersonID], [TerritoryID]  
    FROM [Sales].[SalesOrderHeader];
"""
# ,  CAST([TotalDue] AS DECIMAL(18,2)) AS TotalDue

#sales_filename = os.path.join(directory, "sales_extract.csv")
sales_filename = "sales_extract.csv"
export_to_csv(sales_query, sales_filename)

# Territory query
territory_query = """
    SELECT [TerritoryID], [Name], [CountryRegionCode], [Group] 
    FROM [Sales].[SalesTerritory];
"""
#territory_filename = os.path.join(directory, "territory_extract.csv")
territory_filename = "territory_extract.csv"
export_to_csv(territory_query, territory_filename)

# Close cursor and connection
m_cursor.close()
conn.close()

# load the aws_boto_credentials values
parser = configparser.ConfigParser()
parser.read("pipeline.conf")
access_key = parser.get("aws_boto_credentials", "access_key")
secret_key = parser.get("aws_boto_credentials", "secret_key")
bucket_name = parser.get("aws_boto_credentials", "bucket_name")

# Initialize S3 client
s3 = boto3.client('s3', aws_access_key_id=access_key, aws_secret_access_key=secret_key)

local_filename1 = "sales_extract.csv"
local_filename2 = "territory_extract.csv"

s3_file_sales = local_filename1
s3_file_territory = local_filename2

try:
    # Upload sales extract to S3
    s3.upload_file(local_filename1, bucket_name, s3_file_sales)
    print(f"Successfully uploaded {sales_filename} to S3 bucket '{bucket_name}' as {s3_file_sales}")

    # Upload territory extract to S3
    s3.upload_file(local_filename2, bucket_name, s3_file_territory)
    print(f" Successfully uploaded {territory_filename} to S3 bucket '{bucket_name}' as {s3_file_territory}")

except Exception as e:
    print(f" Error uploading files to S3: {e}")

      



