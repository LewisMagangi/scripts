import os
import time

def get_last_modified_time(file_path):
    try:
        # Get the last modification time of the file
        last_modified_timestamp = os.path.getmtime(file_path)
        
        # Convert the timestamp to a readable format
        last_modified_time = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(last_modified_timestamp))
        
        return last_modified_time
    except FileNotFoundError:
        return "File not found: {}".format(file_path)

# Ask the user to enter the file path
file_path = raw_input("Enter the path to the file you want to check: ")

# Get and print the last modification time
last_modified_time = get_last_modified_time(file_path)
print("Last modified time of {}: {}".format(file_path, last_modified_time))
