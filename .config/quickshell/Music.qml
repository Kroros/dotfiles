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

    implicitWidth: 600;
    implicitHeight: 450;

    HyprlandFocusGrab {
        id: grab;
        active: root.visible;
        windows: [ root ];
    }

    Rectangle {
        anchors.fill: parent;
        color: Colours.background;
        radius: 10;

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
                }
            }

            // TODO: Add EQ here
        }
    }
}
