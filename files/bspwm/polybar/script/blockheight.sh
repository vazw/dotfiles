#!/bin/bash

price=$(curl -sX GET "https://blockchain.info/q/getblockcount" -H  "accept: application/json" )

if [[ ! $price -eq "" ]]; then
    echo "$price" > blockheight
fi
cat blockheight
