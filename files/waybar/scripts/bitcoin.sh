#!/bin/bash

price="$(wget 'https://api.binance.com/api/v3/ticker/price?symbol=BTCUSDT' -q -O - | jq -r .price)"
price_thb="$(wget 'https://api.bitkub.com/api/market/asks?sym=thb_btc&lmt=1' -q -O - | jq -r .result.[0].[3])"
rounded_Price=$(printf "%'.0f\n" "${price}")
# rounded_Price_thb=$(printf "%'.0f\n" "${price_thb}")

price_sats_per_bath=$(echo "1000 / ($price_thb / 100000)" | bc --mathlib)
price_sats_per_bath=$(printf "%'.2f\n" "${price_sats_per_bath}")

if [[ ! ${rounded_Price} -eq 0 ]]; then
	echo " $rounded_Price\$ 1฿=${price_sats_per_bath}⚡" > "$HOME/.config/waybar/scripts/BTCUSD"
fi
cat "$HOME/.config/waybar/scripts/BTCUSD"
