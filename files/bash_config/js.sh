NPM_PACKAGES="${HOME}/.npm-packages"
NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
if [ -d "$NPM_PACKAGES/bin" ]; then
	PATH="$NPM_PACKAGES/bin:$PATH"
fi
export PATH
