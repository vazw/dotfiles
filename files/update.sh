#!/bin/bash

FILES=(*)

for UPDATE_PATH in "${FILES[@]}"; do
	if [[ $UPDATE_PATH != "update.sh" ]]; then
		if [[ -f $UPDATE_PATH ]]; then
			cp "$HOME/.config/$UPDATE_PATH" .
			echo "Copied $UPDATE_PATH"
		fi
		if [[ -d $UPDATE_PATH ]]; then
			cp -r "$HOME/.config/$UPDATE_PATH" .
			echo "Updated $UPDATE_PATH"
		fi
	fi
done
