#!/usr/bin/env bash

while true; do
  ls $HOME/.cache/nvim/server.pipe && rm $HOME/.cache/nvim/server.pipe
  nvim --listen $HOME/.cache/nvim/server.pipe --headless
done
