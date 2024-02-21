#!/bin/env bash

# Check if repository name is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <repository-name>"
    exit 1
fi

# Create a new directory with the name provided as an argument
mkdir "$1"

# Enter the new directory
cd "$1"

# Initialize Git in the current directory
git init

# Create a new README.md file with the name of the repository as the first heading
echo "# $1" >> README.md

# Add the README.md file to the Git repository
git add README.md

# Commit the first commit with a default message
git commit -m "Initial commit"

# Add all other files to the Git repository
git add .

# Commit the second commit with a default message
git commit -m "Add all files"

# Add the remote repository as the origin
git remote add origin "https://github.com/Liquelaliqours/$1.git"

# Push the changes to the master branch of the remote repository
git push -u origin master

# Exit the directory
cd ..