#!/bin/bash

price="$(wget 'https://api.binance.com/api/v3/ticker/price?symbol=BTCUSDT' -q -O - | jq -r .price)"
price_thb="$(wget 'https://api.bitkub.com/api/v3/market/asks?sym=btc_thb&lmt=1' -q -O - | jq -r .result.[0].price)"
rounded_Price=$(printf "%'.0f\n" "${price}")
# rounded_Price_thb=$(printf "%'.0f\n" "${price_thb}")

price_sats_per_bath=$(echo "100000000 / $price_thb" | bc --mathlib)
price_sats_per_bath=$(printf "%'.2f\n" "${price_sats_per_bath}")

if [[ ! ${rounded_Price} -eq 0 ]]; then
    echo " $rounded_Price\$ 1฿=${price_sats_per_bath}⚡" >"$HOME/.config/waybar/scripts/BTCUSD"
fi
