#!/bin/bash
filename="$1"

echo " running "
sed -i "s/PRODUCT/$product/g" "$filename"
