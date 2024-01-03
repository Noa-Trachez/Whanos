#! /bin/bash

# If $1 is not set, set it to the current directory
if [ -z "$1" ]; then
    set -- "."
fi

# Function to check if a file exists
file_exists() {
    if [ -e "$1" ]; then
        return 0  # true
    else
        return 1  # false
    fi
}

# Function to check if a Dockerfile exists
dockerfile_exists() {
    if [ -e "$1/Dockerfile" ]; then
        return 0  # true
    else
        return 1  # false
    fi
}

run_existing_dockerfile() {
    docker build -t test_file $1
}

run_my_dockerfile() {
    docker build -t test_file -f ~/images/$2/Dockerfile.standalone .
}

# Function to detect programming language and Dockerfile
detect_language() {
    local file="$1"
    local lang="$2"

  # Print file
    echo "Checking for [$lang] file at '$file'"
    if file_exists "$file"; then
        echo "Found [ $lang ] language"
        if ! dockerfile_exists "$file"; then
            cp -f $JENKINS_HOME/jobs/docker/images/$2/Dockerfile.standalone ./Dockerfile
        fi
        exit 0
    fi
}

# Define an array of languages and file paths
declare -a languages=("c:$1/Makefile" "java:$1/app/pom.xml" "javascript:$1/package.json" "python:$1/requirements.txt" "befunge:$1/app/main.bf")

# Loop through the array
for lang_info in "${languages[@]}"; do
    IFS=':' read -r lang_name lang_file <<< "$lang_info"
    detect_language "$lang_file" "$lang_name"
done

# If no specific file is found
echo "Language detection failed. No recognized files found."
exit 1
