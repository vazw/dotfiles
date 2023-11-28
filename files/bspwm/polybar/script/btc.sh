#!/bin/bash
price=$(curl -sX GET "https://blockchain.info/ticker" -H  "accept: application/json")
price_usd=$(echo "$price" | jq .USD.last)
sym_usd="$"
# price_thb=$(echo "$price" | jq .THB.last)
# sym_thb="B"

price_usd=$(printf "%'.2f\n" "$price_usd") 
# price_thb=$(printf "%'.0f\n" "$price_thb")

if [[ -n $price_usd ]]; then
    echo "$price_usd$sym_usd" > "$HOME/.config/bspwm/polybar/script/price"
fi

cat "$HOME/.config/bspwm/polybar/script/price"
