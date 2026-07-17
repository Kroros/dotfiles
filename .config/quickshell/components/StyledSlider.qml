import QtQuick.Controls;
import QtQuick;

Slider {
    id: root;

    implicitWidth: 500;

    property bool liveUpdate;
    live: liveUpdate;

    background: Item {
        Rectangle {
            anchors.top: parent.top;
            anchors.bottom: parent.bottom;
            anchors.left: parent.left;

            implicitWidth: root.handle.x - 3;

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

            implicitWidth: parent.width - root.handle.x - root.handle.implicitWidth - root.implicitHeight / 6 - 3;

            color: Colours.foreground;
        }
    }

    handle: Rectangle {
        x: root.visualPosition * root.availableWidth - implicitWidth / 2;
        y: -root.height;

        implicitWidth: 3;
        implicitHeight: 5;
        height: 15;
        radius: 2;
        color: Colours.tertiary;
    }
}
