#!/bin/bash

FILES=(*)
IGNORE="update.sh go $@"
echo "Ignored: $IGNORE"

for UPDATE_PATH in "${FILES[@]}"; do
	if [[ ! " ${IGNORE[*]} " =~ [[:space:]]$UPDATE_PATH[[:space:]] ]]; then
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
