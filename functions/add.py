from datetime import datetime
import mimetypes
from numpy import empty
import pandas as pd
import os

# Get the base directory (project root)
base_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
csv_path = os.path.join(base_dir, "Files", "Dataset2.csv")


def add_csv(name):
    nowdaytime = datetime.now()
    date = nowdaytime.strftime('%d-%m-%Y')
    time = nowdaytime.strftime('%H-%M-%S')
    print(time)
    df = pd.read_csv(csv_path)
    data_af_filter = df.loc[(df['Name '] == name) & (df['Date'] == date)]
    e = pd.unique(data_af_filter['Time']).tolist()
    if(len(e)!=0):
        pasttime = datetime.strptime(e[len(e)-1], "%H-%M-%S")
        current_time = datetime.strptime(time, "%H-%M-%S")
        min_time = current_time - pasttime
    
        if(str(min_time) > "0:05:00"):
            data = {
            'Name ': [name],
            'Date': [date],
            'Time': [time]
            }
            df2 = pd.DataFrame(data)
            df2.to_csv(csv_path, mode='a', index=False, header=False)

    else:
        data = {
            'Name ': [name],
            'Date': [date],
            'Time': [time]
            }
        
            # dataframe from dictionary
        df2 = pd.DataFrame(data)
        df2.to_csv(csv_path, mode='a', index=False, header=False)
