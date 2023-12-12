import os
import filecmp

def are_files_equal(file1, file2):
    """
    Check if two files are equal.
    """
    return filecmp.cmp(file1, file2)

def find_unsimilar_directories(base_directory, reference_file):
    """
    Find subdirectories of push files that are not similar to the reference file.
    """
    unsimilar_directories = []
    for root, dirs, files in os.walk(base_directory):
        for file in files:
            if file.endswith(".push"):
                push_file_path = os.path.join(root, file)
                if not are_files_equal(push_file_path, reference_file):
                    unsimilar_directories.append(root)
                    break  # Stop checking other files in the same directory
            
    return unsimilar_directories

def main():
    # Set 'path_to_file' to the actual path of the file you provided
    path_to_file = '/alx-higher_level_programming/0x13-javascript_objects_scopes_closures/push'
    
    # Set 'base_directory' to the root directory
    base_directory = '/'
    
    unsimilar_directories = find_unsimilar_directories(base_directory, path_to_file)

    if unsimilar_directories:
        print("Subdirectories with push files not similar to the reference file:")
        for directory in unsimilar_directories:
            print(directory)
    else:
        print("All push files in subdirectories are similar to the reference file.")
        
if __name__ == "__main__":
    main()
