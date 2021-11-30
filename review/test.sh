#!/bin/bash

# Check AutoIndex and Create Sample
cat ./etc/nginx/sites-available/default | grep -5 autoindex
mkdir test
touch sample1 sample2 sample3
mv sample* test
mv test ./var/www/html/test
