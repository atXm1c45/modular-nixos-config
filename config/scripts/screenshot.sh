#!/usr/bin/env zsh

DATE=$(date +%Y%m%d_%H%M%S)
FILE_NAME="${HOME}/Pictures/Screenshot_${DATE}.png"

grim -g "$(slurp)" "${FILE_NAME}"

wl-copy < "${FILE_NAME}"
