from etl.extract import  extract_data
from etl.transform import clean_data
from etl.transform import transform_data
from etl.load import load_data

import yaml

with open('dataconfig.yaml','r') as file:
    dataconfig = yaml.safe_load(file)


def run_pipeline():
    # Data extraction
    customers_df = extract_data(dataconfig['customers_path'])
    orders_df = extract_data(dataconfig['orders_path'])
    products_df = extract_data(dataconfig['products_path'])

    # Check if any data extraction failed
    if customers_df is None or orders_df is None or products_df is None:
        print("Error: One or more CSV files could not be loaded. Exiting pipeline.")
        return

    print("Data extraction complete")

    # Data cleaning
    customers_clean = clean_data(customers_df)
    orders_clean = clean_data(orders_df)
    products_clean = clean_data(products_df)

    # Data transformation
    final_df = transform_data(orders_clean, products_clean, customers_clean)
    print("Data transformation complete")

    # Load data into database
    load_data(final_df)

if __name__ == "__main__":
    run_pipeline()

 



