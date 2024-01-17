import os

def count_lines(file_path):
    with open(file_path, 'r') as file:
        return sum(1 for line in file)

def count_lines_in_directory(directory_path):
    total_lines = 0

    for root, dirs, files in os.walk(directory_path):
        for file in files:
            if file.endswith('.py'):
                file_path = os.path.join(root, file)
                total_lines += count_lines(file_path)

    return total_lines

# Replace 'alx-higher_level_programming' with your actual directory name
directory_path = 'alx-higher_level_programming'
lines_count = count_lines_in_directory(directory_path)

print('Total lines of code in {}: {}'.format(directory_path, lines_count))
