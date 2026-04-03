#!/usr/bin/env bash

# CONSTANTS
QS_DIR=$HOME/.config/quickshell
ACTIVE_WIDGET=$(cat $HOME/.cache/qs_active_widget)

TARGET="$1"

if [[ $ACTIVE_WIDGET == "none" ]]; then
    echo $TARGET > $HOME/.cache/qs_active_widget
    quickshell -p $QS_DIR/$TARGET.qml
else
    WIDGET_PID=$(pgrep -f "quickshell.*$TARGET.qml")
    kill $WIDGET_PID
    echo "none" > $HOME/.cache/qs_active_widget
fi
