

# Prompt the user for confirmation
read -p "This will reset your repository to the last commit. Are you sure? (y/n): " choice

# Check if the user confirmed
if [ "$choice" = "y" ]; then
    # Reset to the last commit
    git reset --hard HEAD
    echo "Repository reset to the last commit."
elif [ "$choice" = "n" ]; then
    echo "Reset aborted."
else
    echo "Invalid choice. Reset aborted."
    