#!/bin/bash

man "$@" | col -bx | bat --style changes -l man -p
