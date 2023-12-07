#!/bin/bash
branch_count=$(git branch | wc -l)
echo "Number of branches: $branch_count"
