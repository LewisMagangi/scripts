#!/bin/bash

path_to_file="./alx-higher_level_programming/0x13-javascript_objects_scopes_closures/push"

find_unsimilar_directories() {
    local base_directory="$1"
    local reference_file="$2"
    local unsimilar_directories=()

    while IFS= read -r -d '' push_file; do
	if [[ $push_file == *.push ]]; then
	    if ! cmp -s "$push_file" "$reference_file"; then
		unsimilar_directories+=("$(dirname "$push_file")")
	    fi
	fi
    done < <(find "$base_directory" -type f -name "*.push" -print0)

    echo "${unsimilar_directories[@]}"
}

main() {
    unsimilar_directories=$(find_unsimilar_directories "/" "$path_to_file")

    if [[ -n "${unsimilar_directories[@]}" ]]; then
	echo "Subdirectories with push files not similar to the reference file:"
	printf "%s\n" "${unsimilar_directories[@]}"
    else
	echo "All push files in subdirectories are similar to the reference file."
    fi
}

main
