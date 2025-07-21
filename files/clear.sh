#!/usr/bin/env bash

for dir in *; do
  [ -d "$dir" ] && echo Cleaning "$dir" && rm -rf "$dir"/*
done
