#!/bin/bash
#

price="$(wget 'https://api.binance.com/api/v3/ticker/price?symbol=BTCUSDT' -q -O - | jq -r .price)"
rounded_Price=$(printf "%.0f\n" "${price}")
echo " ${rounded_Price}$"
