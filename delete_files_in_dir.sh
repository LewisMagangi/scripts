#!/bin/bash

# Function to process files in a directory
process_directory() {
    local dir="$1"
    local files=()

    while IFS= read -r -d $'\0' file; do
	files+=("$file")
    done < <(find "$dir" -type f -name "*~" -print0)

    if [ ${#files[@]} -eq 0 ]; then
	echo "No files ending with ~ found in $dir"
	return
    fi

    echo "Files ending with ~ in $dir:"
    printf '%s\n' "${files[@]}"

    read -p "Do you want to delete these files? (y/n): " confirm

    if [ "$confirm" == "y" ]; then
	rm "${files[@]}"
	echo "Files deleted in $dir"
	git add "${files[@]}"
	git commit -m "Delete files ending with ~ in $dir"
	git push
    else
	echo "Files in $dir not deleted."
    fi
}

# Main loop to process subdirectories
for subdirectory in */; do
    if [ -d "$subdirectory" ]; then
	pushd "$subdirectory" >/dev/null
	process_directory "$subdirectory"
	popd >/dev/null
    fi
done
