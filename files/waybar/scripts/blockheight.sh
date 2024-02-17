#!/bin/bash

price=$(curl -sX GET "https://blockchain.info/q/getblockcount" -H  "accept: application/json" )

if [[ ! $price -eq "" ]]; then
    echo "$price" > "$HOME/.config/waybar/scripts/blockheight"
fi
cat "$HOME/.config/waybar/scripts/blockheight"
