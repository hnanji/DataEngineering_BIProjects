from etl.extract import  extract_data
from etl.transform import clean_data
from etl.load import load_data

import yaml

with open('dataconfig.yaml','r') as file:
    dataconfig = yaml.safe_load(file)


def run_pipeline():

    # Data extraction
    df_04 = extract_data(dataconfig['candy04_path'])
    df_05 = extract_data(dataconfig['candy05_path'])
    df_06 = extract_data(dataconfig['candy06_path'])
    df_07 = extract_data(dataconfig['candy07_path'])
    df_08 = extract_data(dataconfig['candy08_path'])
    df_09 = extract_data(dataconfig['candy09_path'])

    # data transformation

    df_04 = clean_data(df_04)
    df_05 = clean_data(df_05)
    df_06 = clean_data(df_06)
    df_07 = clean_data(df_07)
    df_08 = clean_data(df_08)
    df_09 = clean_data(df_09)
    
   
    # Load data into database
    load_data(df_04,df_05,df_06,df_07,df_08,df_09)

if __name__ == "__main__":
    run_pipeline()

 



