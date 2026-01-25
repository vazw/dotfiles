#!/usr/bin/env bash

## THIS IS MY PERSONAL CONFIG FILE ON ASUS ZENBOOK UM5302TA 
## DON'T EXPECT IT TO WORK ON YOUR MACHINE
# Colors
BRed='\033[1;31m'    BGreen='\033[1;32m'    BYellow='\033[1;33m'
BBlue='\033[1;34m'   BPurple='\033[1;35m'   COFF='\033[0m'
## Directories ----------------------------
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

[ -d "$HOME"/.config ] || mkdir "$HOME"/.config
[ -d "$HOME"/.local/bin ] || mkdir -p "$HOME"/.local/bin
[ -d "$HOME"/.local/share ] || mkdir -p "$HOME"/.local/share

echo "$BGreen Applying config $COFF"
cp -r "$SCRIPT_DIR"/files/*  "$HOME"/.config/
echo "$BPurple Copied config files to $COFF $BBlue $HOME/.config $COFF"
cp -r "$SCRIPT_DIR"/darkman/* "$HOME"/.local/share/
echo "$BPurple Copied darkman hook to $COFF $BBlue $HOME/.local/share/ $COFF"
echo "$BGreen Done $COFF"

echo "$BGreen Applying user's script $COFF"
cp "$SCRIPT_DIR"/script/* "$HOME"/.local/bin/
echo "$BPurple Copied script to $COFF $BBlue $HOME/.local/bin $COFF"
cp "$SCRIPT_DIR"/dotbashrc "$HOME"/.bashrc
echo "$BPurple Copied bashrc to $COFF $BBlue $HOME/.bashrc $COFF"
cp "$SCRIPT_DIR"/dotprofile "$HOME"/.profile
echo "$BPurple Copied profile to $COFF $BBlue $HOME/.profile $COFF"
echo "$BGreen Done $COFF"

echo "$BYellow Need Permission to install packages $COFF"
sudo -E bash "$SCRIPT_DIR"/install.sh &&
  echo "$BGreen Done $COFF" ||
  echo "$BRed Failed to Install Packages $COFF"

