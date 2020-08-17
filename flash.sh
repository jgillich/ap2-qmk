#!/bin/bash

set -e

docker build -t ap2-qmk .

rm -rf `pwd`/bin
id=$(docker create ap2-qmk)
docker cp $id:/root/bin `pwd`/bin
docker rm $id

printf "\n\n$(tput bold)To flash, you will have to unplug your keyboard, hold escape and plug it back in.$(tput sgr0)"
printf "\nTo proceed, enter [y]. Flashing will begin after 10 seconds. Do not unplug your keyboard during the flashing process.\n"

read -n1 input

if [ $input = "y" ]; then
  printf "\n\nFlashing in 10 seconds..."
  sleep 10
  bin/annepro2_tools bin/annepro2_c15_default.bin
  bin/annepro2_tools -t led bin/annepro2-shine.bin
else
  printf "\nCancelled"
  exit 1
fi
