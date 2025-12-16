#!/usr/bin/env bash

DIR="$HOME/Videos/Recordings"
mkdir -p "$DIR"
STATE_FILE="/tmp/recording_filename"

if pgrep -x "wf-recorder" > /dev/null; then
    pkill -SIGINT -x wf-recorder
    
    if [ -f "$STATE_FILE" ]; then
        LAST_FILE=$(cat "$STATE_FILE")
        notify-send -u normal "🔴 Recording Stopped" "Saved to: $(basename "$LAST_FILE")"
        rm "$STATE_FILE"
    else
        notify-send -u normal "🔴 Recording Stopped" "Video saved."
    fi
else
    FILENAME="$DIR/Rec_$(date +%Y-%m-%d_%H-%M-%S).mp4"
    echo "$FILENAME" > "$STATE_FILE"

    nohup wf-recorder -a --file="$FILENAME" > /dev/null 2>&1 &
    
    notify-send -u low "🟢 Recording Started" "Capturing screen & audio..."
fi
