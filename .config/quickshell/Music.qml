import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import QtQuick.Effects;
import "./components"
import "./widgetUtils"

PanelWindow {
    id: root;

    readonly property int secondsProgress: MPlayer.progress % 60;
    readonly property real minutesProgress: (MPlayer.progress - secondsProgress) / 60;
    readonly property string progress: minutesProgress + ":" + (secondsProgress < 10 ? "0" + secondsProgress : secondsProgress);

    readonly property int secondsLength: MPlayer.length % 60;
    readonly property real minutesLength: (MPlayer.length - secondsLength) / 60;
    readonly property string length: minutesLength + ":" + (secondsLength < 10 ? "0" + secondsLength : secondsLength);

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
        color: Colours.background;
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
                    source: '/home/david/hdd/Images/Code Award.png';

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
                        text: MPlayer.title;
                    }

                    StyledText {
                        id: artistText;
                        color: Colours.primary;
                        text: MPlayer.artist;
                        font.pixelSize: 20;
                    }

                    RowLayout {
                        StyledText {
                            id: currentPos;
                            color: Colours.foreground;
                            text: root.progress;
                        }

                        Slider {
                            id: slider;

                            implicitWidth: 500;
                            value: MPlayer.progress / MPlayer.length;

                            live: false;

                            background: Item {
                                Rectangle {
                                    anchors.top: parent.top;
                                    anchors.bottom: parent.bottom;
                                    anchors.left: parent.left;

                                    implicitWidth: slider.handle.x - slider.implicitHeight / 6; 
                                    gradient: Gradient {
                                        orientation: Gradient.Horizontal;
                                        GradientStop { position: 0.0; color: Colours.primary }
                                        GradientStop { position: 0.5; color: Colours.secondary }
                                        GradientStop { position: 1.0; color: Colours.tertiary }
                                    }
                                }

                                Rectangle {
                                    anchors.top: parent.top;
                                    anchors.bottom: parent.bottom;
                                    anchors.right: parent.right;

                                    implicitWidth: parent.width - slider.handle.x - slider.handle.implicitWidth - slider.implicitHeight / 6;

                                    color: Colours.foregroundDark;
                                }
                            }

                            handle: Rectangle {
                                x: slider.visualPosition * slider.availableWidth - implicitWidth / 2;

                                implicitWidth: slider.implicitHeight / 4.5;
                                implicitHeight: slider.implicitHeight;

                                color: Colours.border;
                            }
                        }
                        StyledText {
                            id: trackLength;
                            color: Colours.foreground;
                            text: root.length;
                        }
                    }
                }
            }

            // TODO: Add EQ here
        }
    }
}
