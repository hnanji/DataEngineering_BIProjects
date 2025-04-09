Project: Data Pipeline for ETL into Amazon Redshift
Project Overview
This project is an end-to-end ETL (Extract, Transform, Load) data pipeline that automates data ingestion from operational relational databases, stores the extracted data in an Amazon S3 bucket, and loads it into Amazon Redshift for reporting and analysis using Power BI.

The pipeline is triggered using Python scripts and utilizes Boto3, Amazon's SDK for interacting with AWS services. The solution enables efficient data processing, transformation, and visualization for business intelligence (BI) reporting.

Key Features
- Automated Data Extraction: Python scripts pull data from relational databases.
- AWS S3 Storage: Extracted data is stored in an Amazon S3 bucket as CSV or Parquet files.
- custome VPN with an internet gateway, public subnet, route table and associated between them
- A security group for Redshift refencing our own IP address
- parameter group to configure the resdshift cluster
- Reshift node cluster that launches in the public subnet of the VPC
- Amazon Redshift Loading: Uses COPY commands to load data efficiently into a Redshift cluster.
- Scalable & Cost-Effective: Serverless design leveraging AWS-managed services.
- Business Intelligence: Power BI is used for dashboards and reporting.

Tech Stack
Programming Language: Python

Data Storage: Amazon S3

Database: Amazon Redshift

Orchestration & Automation: Python, Boto3

Visualization: Power BI

Project Architecture
Extract: Python scripts connect to the relational database (e.g. PostgreSQL, MySQL) and extract data.

Store: Data is temporarily stored in Amazon S3 in CSV/Parquet format

Load: Python scripts trigger the Redshift COPY command to import data from S3.

Analyze: Power BI is connected to Redshift for visualization and reporting.

Installation & Setup
Prerequisites
AWS Account

Python 3.x

IAM Role with Redshift & S3 permissions

Boto3 (pip install boto3)

SQL client for Redshift


# commands to run cloudformation

Notes:
Make sure you change the name of the S3 bucket in params.json

* aws cloudformation create-stack --stack-name first-redshift --template-body file://create_cluster.json --parameters file://params.json
* aws cloudformation describe-stacks --stack-name first-redshift
* aws cloudformation delete-stack --stack-name first-redshift
