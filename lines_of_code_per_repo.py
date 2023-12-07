import os
import sys

def count_lines(file_path):
    with open(file_path, 'r') as file:
        return sum(1 for line in file)

def count_lines_in_directory(directory_path, file_extensions):
    total_lines = 0

    for root, dirs, files in os.walk(directory_path):
        for file in files:
            if not file.startswith('.#') and file.endswith(tuple(file_extensions)):
                file_path = os.path.join(root, file)
                total_lines += count_lines(file_path)

    return total_lines

if __name__ == "__main__":
    # Check if the correct number of arguments is provided
    if len(sys.argv) < 2:
        print("Usage: python count_lines_of_codes.py <directory_path>")
        sys.exit(1)

    directory_path = sys.argv[1]
    # Specify the file extensions you want to include
    file_extensions = ['.py', '.c', '.cpp', '.js', '.sh', '.html', '.css']
    
    lines_count = count_lines_in_directory(directory_path, file_extensions)

    print('Total lines of code in {}: {}'.format(directory_path, lines_count))
