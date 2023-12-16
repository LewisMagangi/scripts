#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <push_script_file> <directory1> [directory2] [directory3] ..."
    exit 1
fi

push_script_file=$1
shift # Shift the first argument to access the directories

# Function to add push script to directories and subdirectories
add_push_script_to_directories() {
    local push_script_file=$1
    shift # Shift the first argument to access the directories

    for provided_directory in "$@"; do
        # Check if the push script already exists in the provided directory
        if [ ! -e "$provided_directory/$push_script_file" ]; then
            # Extract the specific directory name
            specific_dir_name=$(basename "$provided_directory")

            # Generate commit message based on the directory name
            commit_message="Adding the push script to the directory: $specific_dir_name"

            # Commit the changes in the main directory
            git add "$provided_directory/$push_script_file"
            git commit -m "$commit_message"

            # List subdirectories without the push script file
            subdirs=$(find "$provided_directory" -maxdepth 1 -type d ! -name "$specific_dir_name" -exec sh -c "[ ! -e {}/$push_script_file ] && echo {}" \;)
            for subdir in $subdirs; do
                subdir_name=$(basename "$subdir")
                # Exclude .git directory
                if [ "$subdir_name" != ".git" ]; then
                    # Generate commit message based on the subdirectory name
                    commit_message="Adding the push script to the subdirectory: $subdir_name"

                    # Commit the changes in the subdirectory
                    git add "$provided_directory/$subdir_name/$push_script_file"
                    git commit -m "$commit_message"
                fi
            done
        else
            echo "Push script already exists in $provided_directory. Checking subdirectories..."
            # Check for subdirectories and push the script if they exist
            subdirs=$(find "$provided_directory" -maxdepth 1 -type d ! -name "$(basename "$provided_directory")")
            for subdir in $subdirs; do
                subdir_name=$(basename "$subdir")
                # Exclude .git directory
                if [ "$subdir_name" != ".git" ]; then
                    # Check if the push script already exists in the subdirectory
                    if [ ! -e "$subdir/$push_script_file" ]; then
                        # Generate commit message based on the subdirectory name
                        commit_message="Adding the push script to the subdirectory: $subdir_name"

                        # Commit the changes in the subdirectory
                        git add "$provided_directory/$subdir_name/$push_script_file"
                        git commit -m "$commit_message"
                    else
                        echo "Push script already exists in $subdir. Skipping."
                    fi
                fi
            done
        fi
    done
}

# Function to list directories and subdirectories
list_directories_and_subdirectories() {
    echo "Directories and their subdirectories:"
    for provided_directory in "$@"; do
        echo "$provided_directory"
        subdirs=$(find "$provided_directory" -maxdepth 1 -type d ! -name "$(basename "$provided_directory")")
        for subdir in $subdirs; do
            subdir_name=$(basename "$subdir")
            # Exclude .git directory
            if [ "$subdir_name" != ".git" ]; then
                echo "  $subdir_name"
            fi
        done
    done
}

# Function to prompt for confirmation
prompt_for_confirmation() {
    read -r -p "Do you want to proceed with pushing? (y/n): " choice
    if [ "$choice" != "y" ]; then
        echo "Script execution aborted."
        exit 0
    fi
}

# Call the function to list directories and subdirectories
list_directories_and_subdirectories "$@"

# Call the function to prompt for confirmation
prompt_for_confirmation

# Call the function to add push script to directories and subdirectories
add_push_script_to_directories "$push_script_file" "$@"
