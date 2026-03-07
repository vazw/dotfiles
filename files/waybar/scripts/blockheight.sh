#!/bin/bash

bash -c "$HOME/.config/waybar/scripts/bitcoin.sh"

BLOCKHEIGHT=$(curl -sX GET "https://blockchain.info/q/getblockcount" -H "accept: application/json")

if [[ -n ${BLOCKHEIGHT} && ${BLOCKHEIGHT} -gt 0 ]]; then
    echo "$BLOCKHEIGHT" >"$HOME/.config/waybar/scripts/blockheight"
fi

block=$(cat "$HOME/.config/waybar/scripts/blockheight")
btc_price=$(cat "$HOME/.config/waybar/scripts/BTCUSD")

printf "%s\n%s" "$block" "$btc_price"
