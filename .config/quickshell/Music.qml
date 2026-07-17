import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import QtQuick.Effects;
import "./components"
import "./widgetUtils"

PanelWindow {
    id: root;
    WlrLayershell.namespace: "quickshell:menu";
    WlrLayershell.layer: WlrLayer.Overlay;

    readonly property int secondsProgress: MPlayer.musicData.progress % 60;
    readonly property real minutesProgress: (MPlayer.musicData.progress - secondsProgress) / 60;
    readonly property string progress: minutesProgress + ":" + (secondsProgress < 10 ? "0" + secondsProgress : secondsProgress);

    readonly property int secondsLength: MPlayer.musicData.length % 60;
    readonly property real minutesLength: (MPlayer.musicData.length - secondsLength) / 60;
    readonly property string length: minutesLength + ":" + (secondsLength < 10 ? "0" + secondsLength : secondsLength);

    readonly property real ratio: MPlayer.musicData.progress / MPlayer.musicData.length;


    property bool seeking: false;

    focusable: true;

    anchors {
        top: true;
        left: true;
    }

    color: "transparent";

    margins {
        top: 10
        left: 10
    }

    implicitWidth: 900;
    implicitHeight: 450;

    HyprlandFocusGrab {
        id: grab;
        active: root.visible;
        windows: [ root ];
    }

    Rectangle {
        anchors.fill: parent;
        color: Colours.menu;
        radius: 0;

        ColumnLayout {
            anchors {
                top: parent.top;
                left: parent.left;
                topMargin: 20;
                leftMargin: 20;
            }
            RowLayout {
                Image {
                    id: image;
                    source: MPlayer.musicData.albumArt;

                    width: 200;
                    height: 200;
                    visible: false;
                }

                MultiEffect {
                    source: image;
                    anchors.fill: image;
                    maskEnabled: true;
                    maskSource: mask;
                }

                Item {
                    id: mask;
                    width: image.width;
                    height: image.height;
                    layer.enabled: true;
                    visible: false;

                    Rectangle {
                        width: image.width;
                        height: image.height;
                        radius: width/2;
                        color: "black";
                    }
                }

                ColumnLayout {
                    Layout.leftMargin: 16;
                    StyledText {
                        id: titleText;
                        font.pixelSize: 22;
                        color: Colours.primary;
                        text: MPlayer.musicData.title;
                    }

                    StyledText {
                        id: artistText;
                        color: Colours.primary;
                        text: MPlayer.musicData.artist;
                        font.pixelSize: 20;
                    }

                    RowLayout {
                        StyledText {
                            id: currentPos;
                            color: Colours.foreground;
                            text: root.progress;
                        }

                        StyledSlider {
                            id: progBar

                            Connections {
                                target: MPlayer;
                                function onMusicDataChanged() {
                                    if (!progBar.pressed && !root.seeking) {
                                        progBar.value = root.ratio;
                                    }
                                }
                            }

                            onPressedChanged: {
                                if (pressed) {
                                    root.seeking = true;
                                    seekDebounceTimer.stop();
                                } else {
                                    let pos = value * MPlayer.musicData.length;
                                    console.log(pos);
                                    Hyprland.dispatch(`hl.dsp.exec_cmd("playerctl -p spotify position ${pos}")`);
                                    seekDebounceTimer.restart();
                                }
                            }
                        }

                        
                        StyledText {
                            id: trackLength;
                            color: Colours.foreground;
                            text: root.length;
                        }
                    }

                    RowLayout {
                        Layout.leftMargin: (parent.implicitWidth - implicitWidth) / 2;

                        StyledButton {
                            id: shuffleButton;
                            buttonText: "󰒝";
                            fontSize: 32;
                            fgColour: MPlayer.musicData.shuffleStat == "true" ? Colours.secondary : Colours.foreground;
                            bgColour: "transparent";

                            Layout.margins: 12;
                            onClicked: () => {
                                Hyprland.dispatch(`hl.dsp.exec_cmd("playerctl -p spotify shuffle toggle")`);
                            }
                        }
                        StyledButton {
                            id: prevButton;
                            buttonText: "󰼨";
                            fontSize: 56;
                            fgColour: Colours.secondary;
                            bgColour: "transparent";
                            
                            Layout.margins: 12;
                            onClicked: () => {
                                Hyprland.dispatch(`hl.dsp.exec_cmd("playerctl -p spotify previous")`);
                            }
                        }
                        StyledButton {
                            id: playPauseButton
                            buttonText: MPlayer.musicData.pauseStat == "Paused" ? "󰏤" : "";
                            fontSize: 64;
                            fgColour: Colours.secondary;
                            bgColour: "transparent";

                            Layout.margins: 12;
                            onClicked: () => {
                                Hyprland.dispatch(`hl.dsp.exec_cmd("playerctl -p spotify play-pause")`);
                            }
                        }
                        StyledButton {
                            id: nextButton;
                            buttonText: "󰼧";
                            fontSize: 56;
                            fgColour: Colours.secondary;
                            bgColour: "transparent";

                            Layout.margins: 12;
                            onClicked: () => {
                                Hyprland.dispatch(`hl.dsp.exec_cmd("playerctl -p spotify next")`);
                            }
                        }

                        StyledButton{
                            id: loopButton;
                            buttonText: MPlayer.musicData.loopStat == "Track" ? "󰑘" : "󰑖";
                            fontSize: 32;
                            fgColour: MPlayer.musicData.loopStat == "None" ? Colours.foreground : Colours.secondary;
                            bgColour: "transparent";

                            Layout.margins: 12;
                            onClicked: () => {
                                let mode = MPlayer.musicData.loopStat == "Track" ? "None" : MPlayer.musicData.loopStat == "None" ? "Playlist" : "Track";
                                Hyprland.dispatch(`hl.dsp.exec_cmd("playerctl -p spotify loop ${mode}")`);
                            }
                        }
                    }

                    StyledSlider {
                        id: volumeSlider;

                        implicitWidth: parent.implicitWidth * 0.1;

                        value: MPlayer.musicData.volume;
                        liveUpdate: false;

                        onValueChanged: {
                            if (pressed) {
                                Hyprland.dispatch(`hl.dsp.exec_cmd("playerctl -p spotify volume ${value}")`);
                            }
                        }
                    }
                }
            }

            // TODO: Add EQ here
        }
    }

    Timer {
        id: seekDebounceTimer;
        interval: 1000;
        onTriggered: root.seeking = false;
    }
}
