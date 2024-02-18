#!/bin/bash

filename=$1
product=$2
endpoint=$3
request_uri=$4
index=$5

mapfile -t client_urls < url_file

for ((i=0; i<${#client_urls[@]}; i++)); do
    if grep -q "DOMAIN$i\b" "$filename"; then
        sed -i "s/DOMAIN$i\b/${client_urls[i]}/g" "$filename"
    else
        echo "Error: 'DOMAIN$i' not found in $filename."
    fi
done

sed -i "s/PRODUCT/$product/g" "$filename"
sed -i "s/ENDPOINT/$endpoint/g" "$filename"
sed -i "s/REQ_URI$request_uri/g" "$filename"
sed -i "s/INDEX/$index/g" "$filename"

echo "Replacements complete in $filename."
