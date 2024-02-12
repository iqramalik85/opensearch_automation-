
#!/bin/bash
file=$1

echo -n "Enter the replacement word for 'Product_name': "
read -r product
echo -n "Enter the replacement word for 'Endpoint_name' with 1st alphabet capital: "
read -r endpoint
echo -n "Enter the replacement word for 'Request_uri': "
read -r request_uri
echo -n "Enter the replacement word for 'Default-index-pattern': "
read -r def_index
echo -n "Enter the replacement word for 'Index-pattern': "
read -r index
mapfile -t client_urls < domain_file
for ((i=0; i<${#client_urls[@]}; i++)); do
    if grep -q "DOMAIN$((i+1))" "$file"; then
        sed -i "s/DOMAIN$((i+1))/${client_urls[i]}/g" "$file"
    else
        echo "Error: 'DOMAIN$((i+1))' not found in $file."
    fi
done
sed -i "s/PRODUCT/$product/g" "$file"
sed -i "s/ENDPOINT/$endpoint/g" "$file"
sed -i "s/REQ_URI/$request_uri/g" "$file"
sed -i "s/DEF_INDEX/$def_index/g" "$file"
sed -i "s/INDEX/$index/g" "$file"
echo "Replacements complete in $file."
