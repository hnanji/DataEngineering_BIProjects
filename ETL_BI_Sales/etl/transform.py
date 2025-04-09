# import modules
import pandas as pd

# clean data
def clean_data(df: object) -> object:
  
  # Modify the 'product' column to retain only the first word
    df['Product'] = df['Product'].str.split().str[0]

    print("data cleaning is complete")

    return df

