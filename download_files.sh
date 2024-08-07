#!/bin/bash

# Define the directory to download files to
DOWNLOAD_DIR="library"

# Create the download directory if it doesn't exist
mkdir -p "$DOWNLOAD_DIR"

# Function to download a file from a URL
download_file() {
    local url="$1"
    local output="$2"
    wget -q "$url" -O "$output"
}

# Read the YAML file and download each file
while IFS= read -r line; do
    if [[ "$line" == name:* ]]; then
        filename=$(echo "$line" | cut -d: -f2 | xargs)
    elif [[ "$line" == url:* ]]; then
        url=$(echo "$line" | cut -d: -f2 | xargs)
        download_file "$url" "$DOWNLOAD_DIR/$filename"
    fi
done < download.yml

echo "Download completed."
