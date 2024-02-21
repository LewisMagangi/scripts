#!/bin/env bash

# Check if repository name is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <repository-name>"
    exit 1
fi

# Initialize Git in the current directory
git init

# Add all files to the Git repository
git add .

# Commit the first commit with a default message
git commit -m "Initial commit"

# Add the remote repository as the origin
git remote add origin "https://github.com/Liquelaliqours/$1.git"

# Push the changes to the master branch of the remote repository
git push -u origin master
