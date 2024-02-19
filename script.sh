#!/bin/bash

filename=$1
product=$2
endpoint=$3
request_uri=$4
index=$5

mapfile -t client_urls < domain_file

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

git config --global user.email "malikayra85@gmail.com"
git config --global user.name "iqramalik85"
git init
git remote add origin git@github.com/iqramalik85/opensearch_automation-.git
git branch -M main
git add .
git commit -m 'feat: My first feature'
git push -u origin main

echo "Replacements complete in $filename. Changes pushed to GitHub."
