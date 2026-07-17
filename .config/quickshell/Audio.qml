import QtQuick;
import Quickshell;
import Quickshell.Wayland;
import Quickshell.Hyprland;
import Quickshell.Services.Pipewire;
import QtQuick.Controls;
import QtQuick.Layouts;
import "./components";
import ".";

PanelWindow {
    id: root;
    WlrLayershell.namespace: "quickshell:menu";
    WlrLayershell.layer: WlrLayer.Overlay;

    property int currentSelection: 0;

    property var audioSinks: Pipewire.nodes.values.filter(n => n.isSink && !n.isStream);

    PwObjectTracker {
        objects: audioSinks;
    }

    focusable: true;

    implicitWidth: 640;
    implicitHeight: 360;

    color: "transparent";

    Rectangle {
        id: container;
        anchors.fill: parent;
        color: Colours.menu;

        ColumnLayout {
            id: audioOptions;

            focus: true;
            Keys.onReleased: (event) => {
                if (event.key == Qt.Key_K || event.key == Qt.Key_Up) {
                    root.currentSelection = (root.currentSelection - 1 + root.audioSinks.length)  % root.audioSinks.length;
                    event.accepted = true;
                }
                if (event.key == Qt.Key_J || event.key == Qt.Key_Down) {
                    root.currentSelection = (root.currentSelection + 1)  % root.audioSinks.length;
                    event.accepted = true;
                }
                if (event.key == Qt.Key_Enter || event.key == Qt.Key_Return) {
                    Pipewire.preferredDefaultAudioSink = root.audioSinks[root.currentSelection];
                    Hyprland.dispatch('hl.dsp.exec_cmd("qs ipc -p $HOME/.config/quickshell/Main.qml call main toggleWidget Audio")');
                    event.accepted = true;
                }
                if (event.key == Qt.Key_Escape) {
                    Hyprland.dispatch('hl.dsp.exec_cmd("qs ipc -p $HOME/.config/quickshell/Main.qml call main toggleWidget Audio")');
                    event.accepted = true;
                }
                if (event.key == Qt.Key_H || event.key == Qt.Key_Left) {
                    root.audioSinks[root.currentSelection].audio.volume -= 0.05;
                }
                if (event.key == Qt.Key_L || event.key == Qt.Key_Right) {
                    let v = root.audioSinks[root.currentSelection].audio.volume; 
                    root.audioSinks[root.currentSelection].audio.volume = (v + 0.05) > 1 ? 1 : v + 0.05;;
                }
                if (event.key == Qt.Key_M) {
                    console.log(root.audioSinks[root.currentSelection].audio.muted);
                    root.audioSinks[root.currentSelection].audio.muted = !root.audioSinks[root.currentSelection].audio.muted;
                }
            }

            anchors.horizontalCenter: parent.horizontalCenter;
            anchors.top: parent.top;
            anchors.topMargin: 10;

            Repeater {
                model: root.audioSinks;
                delegateModelAccess: DelegateModel.ReadOnly;
                delegate: Rectangle {
                    id: audioSinkCard;

                    color: index == root.currentSelection ? Colours.backgroundAlt : "transparent";

                    implicitHeight: 50;
                    implicitWidth: 620;

                    RowLayout {
                        anchors.left: parent.left;
                        anchors.leftMargin: 5;

                        StyledText {
                            text: {
                                var v = modelData.audio.volume;
                                return modelData.audio.muted ? "󰖁" :
                                v >= 0.75 ? "󰕾" : 
                                v >= 0.25 ? "󰖀" : 
                                v > 0 ? "󰕿" : "󰖁";
                            }

                            font.pixelSize: 32;
                        }
                        ColumnLayout {
                            anchors.top: parent.top;
                            anchors.left: parent.left;
                            anchors.leftMargin: 50;
                            anchors.topMargin: 5;
                            StyledText {
                                text: modelData.description.length > 48 ? modelData.description.slice(0, 48) + "..." : modelData.description;
                            }

                            StyledSlider {
                                value: modelData.audio.volume;
                                liveUpdate: true;

                                onValueChanged: {
                                    if (pressed) {
                                        modelData.audio.volume = value;
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        HyprlandFocusGrab {
            id: grab;
            active: root.visible;
            windows: [ audioOptions ];
            onActiveChanged: {
                if (active) {
                    audioOptions.forceActiveFocus();
                }
            }
        }
    }
}
