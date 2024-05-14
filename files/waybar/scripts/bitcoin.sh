#!/bin/bash
#

price="$(wget 'https://api.binance.com/api/v3/ticker/price?symbol=BTCUSDT' -q -O - | jq -r .price)"
rounded_Price=$(printf "%'.0f\n" "${price}")
if [[ ! $rounded_Price -eq 0 ]]; then
    echo "" "${rounded_Price}" > "$HOME/.config/waybar/scripts/BTCUSD"
fi
cat "$HOME/.config/waybar/scripts/BTCUSD"
