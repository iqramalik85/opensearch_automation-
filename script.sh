#!/bin/bash
filename="$1"
product="$2"
endpoint="$3"
request_uri="$4"
index="$5"

# Check if the file exists
if [ ! -f "$filename" ]; then
    echo "File $filename not found."
    exit 1
fi

# Read the client URLs from the file
mapfile -t client_urls < url_file

# Loop through the client_urls and use sed to perform the replacements in the file
for ((i=1; i<${#client_urls[@]}; i++)); do
    # Check if the word "DOMAIN" with the current index exists in the file before using sed
    if grep -q "DOMAIN$i\b" "$filename"; then
        sed -i "s/DOMAIN$i\b/${client_urls[i]}/g" "$filename"
    else
        echo "Error: 'DOMAIN$i' not found in $filename."
    fi
done

# Perform additional replacements based on parameters
sed -i "s/PRODUCT/$product/g" "$filename"
sed -i "s/ENDPOINT/$endpoint/g" "$filename"
sed -i "s/REQ_URI/$request_uri/g" "$filename"
sed -i "s/INDEX/$index/g" "$filename"
echo "Replacements complete in $filename."
