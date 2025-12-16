#!/bin/sh

exec 9>/tmp/satty.lock
if ! flock -n 9; then
    exit 1
fi

DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"

COUNT=$(find "$DIR" -maxdepth 1 -name "Screenshot-*" | wc -l)
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
FILENAME="$DIR/Screenshot-${COUNT}_${TIMESTAMP}.png"

grim -t ppm - | satty --filename - --fullscreen --output-filename "$FILENAME" 9>&-
