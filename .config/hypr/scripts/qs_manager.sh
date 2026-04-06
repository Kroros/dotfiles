#!/usr/bin/env bash

# CONSTANTS
QS_DIR=$HOME/.config/quickshell
ACTIVE_WIDGET=$(cat $HOME/.cache/qs_active_widget)

TARGET="$1"

if [[ "$ACTIVE_WIDGET" == "none" ]]; then
    quickshell -p $QS_DIR/$TARGET.qml &
    echo "$TARGET" > $HOME/.cache/qs_active_widget
else
    pkill -f "quickshell.*$TARGET.qml"
    echo "none" > $HOME/.cache/qs_active_widget
fi
