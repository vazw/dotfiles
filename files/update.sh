#!/usr/bin/env bash

FILES=(*)

for UPDATE_PATH in "${FILES[@]}" ;do
    if [[ $UPDATE_PATH != "update.sh" ]]; then
        cp ~/.config/"$UPDATE_PATH"/ -ru .
        echo "Updated $UPDATE_PATH"
    fi
done
