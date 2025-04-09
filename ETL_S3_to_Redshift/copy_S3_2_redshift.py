import boto3
import configparser
import psycopg2

# Load configuration
parser = configparser.ConfigParser()
parser.read("pipeline.conf")

# Read AWS and Redshift credentials
dbname = parser.get("aws_creds", "database")
user = parser.get("aws_creds", "username")
password = parser.get("aws_creds", "password")
host = parser.get("aws_creds", "host")
port = parser.get("aws_creds", "port")  # Ensure port is an integer

# Connect to the Redshift cluster
try:
    rs_conn = psycopg2.connect(
        dbname=dbname,
        user=user,
        password=password,
        host=host,
        port=port
    )
    print("Connected to Amazon Redshift successfully!")
except psycopg2.Error as e:
    print(f" Error connecting to Redshift: {e}")
    exit()

# Load the account_id, iam_role, and S3 bucket name
account_id = parser.get("aws_boto_credentials", "account_id")
iam_role = parser.get("aws_creds", "iam_role")
bucket_name = parser.get("aws_boto_credentials", "bucket_name")

# Truncate the target table in Redshift
try:
    cur = rs_conn.cursor()
    cur.execute("TRUNCATE my_schema.table1")
    print("Table truncated successfully.")
except psycopg2.Error as e:
    print(f"Error truncating table: {e}")

# Define S3 file path and IAM role string
file_path = f"s3://{bucket_name}/sales_extract.csv"
role_string = f"arn:aws:iam::{account_id}:role/{iam_role}"

# Run the COPY command to load the file into Redshift
copy_sql = """
    COPY my_schema.table1
    FROM %s
    IAM_ROLE %s;
"""

try:
    cur.execute(copy_sql, (file_path, role_string))
    rs_conn.commit()
    print(" Data copied successfully from S3 to Redshift.")
except psycopg2.Error as e:
    print(f"Error copying data: {e}")
    rs_conn.rollback()

# Close cursor and connection
cur.close()
rs_conn.close()
print("Redshift connection closed.")
