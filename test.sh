#!/bin/bash

read -e -p "Wordpress Port: " -i "8181" wpp
   -=${wpp:-"8181"}

echo "wpp=${wpp:-"8181"}" > test.yml

exit
