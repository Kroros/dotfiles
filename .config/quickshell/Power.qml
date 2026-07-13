import QtQuick;
import Quickshell;
import Quickshell.Wayland;
import Quickshell.Hyprland;
import QtQuick.Controls;
import QtQuick.Layouts;
import "./components";
import "./widgetUtils";
import ".";

PanelWindow {
    id: root;
    WlrLayershell.namespace: "quickshell:powermenu";
    WlrLayershell.layer: WlrLayer.Overlay;

    property int currentSelection: 0;

    onVisibleChanged: () => {
        currentSelection = 0;
        PowerUtils.uptimeProc.running = root.visible;
        PowerUtils.uptimeTimer.running = root.visible;
        PowerUtils.uptimeTimer.repeat = root.visible;
    };
    focusable: true;

    implicitHeight: 1080;
    implicitWidth: 1920;

    anchors: {
        left: true;
        right: true;
        bottom: true;
        top: true;
    }

    color: "transparent";
    exclusionMode: ExclusionMode.Ignore;

    Rectangle {
        id: container;
        anchors.fill: parent;

        color: "#66000007";

        ColumnLayout {
            anchors.centerIn: parent;
            StyledText {
                color: Colours.primary;
                text: "UPTIME: " + PowerUtils.uptimeText;
                font.pixelSize: 64;
            }

            RowLayout {
                id: powerOptions;
                focus: true;

                Keys.onReleased: (event) => {
                    if (event.key == Qt.Key_H || event.key == Qt.Key_Left) {
                        root.currentSelection = (root.currentSelection - 1 + 6)  % 6;
                        event.accepted = true;
                    }

                    if (event.key == Qt.Key_L || event.key == Qt.Key_Right) {
                        root.currentSelection = (root.currentSelection + 1)  % 6;
                        event.accepted = true;
                    }

                    if (event.key == Qt.Key_Enter || event.key == Qt.Key_Return) {
                        PowerUtils.handlePowerSelection(root.currentSelection);
                        event.accepted = true;
                    }

                    if (event.key == Qt.Key_Escape) {
                        Hyprland.dispatch('hl.dsp.exec_cmd("qs ipc -p $HOME/.config/quickshell/Main.qml call main toggleWidget Power")');
                    }
                }

                StyledButton {
                    implicitWidth: 100;
                    implicitHeight: 100;
                    buttonText: "";
                    fontSize: 48;
                    bgColour: root.currentSelection == 0 ? Colours.backgroundAlt : Colours.disabled;
                    onClicked: () => PowerUtils.handlePowerSelection(0);
                }
                StyledButton {
                    implicitWidth: 100;
                    implicitHeight: 100;
                    buttonText: "󰜉";
                    fontSize: 48;
                    bgColour: root.currentSelection == 1 ? Colours.backgroundAlt : Colours.disabled;
                    onClicked: () => PowerUtils.handlePowerSelection(1);
                }
                StyledButton {
                    implicitWidth: 100;
                    implicitHeight: 100;
                    buttonText: "";
                    fontSize: 48;
                    bgColour: root.currentSelection == 2 ? Colours.backgroundAlt : Colours.disabled;
                    onClicked: () => PowerUtils.handlePowerSelection(2);
                }
                StyledButton {
                    implicitWidth: 100;
                    implicitHeight: 100;
                    buttonText: "󰜗";
                    fontSize: 48;
                    bgColour: root.currentSelection == 3 ? Colours.backgroundAlt : Colours.disabled;
                    onClicked: () => PowerUtils.handlePowerSelection(3);
                }
                StyledButton {
                    implicitWidth: 100;
                    implicitHeight: 100;
                    buttonText: "󰬩";
                    fontSize: 48;
                    bgColour: root.currentSelection == 4 ? Colours.backgroundAlt : Colours.disabled;
                    onClicked: () => PowerUtils.handlePowerSelection(4);
                }
                StyledButton {
                    implicitWidth: 100;
                    implicitHeight: 100;
                    buttonText: "󰤁";
                    fontSize: 48;
                    bgColour: root.currentSelection == 5 ? Colours.backgroundAlt : Colours.disabled;
                    onClicked: () => PowerUtils.handlePowerSelection(5);
                }
            }

            HyprlandFocusGrab {
                id: grab;
                active: root.visible;
                windows: [ powerOptions ];
                onActiveChanged: {
                    if (active) {
                        powerOptions.forceActiveFocus();
                    }
                }
            }
        }
    }
}
