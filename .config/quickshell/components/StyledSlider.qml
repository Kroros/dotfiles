import QtQuick.Controls;
import QtQuick;

Slider {
    id: root;

    implicitWidth: 500;

    live: false;

    background: Item {
        Rectangle {
            anchors.top: parent.top;
            anchors.bottom: parent.bottom;
            anchors.left: parent.left;

            implicitWidth: root.handle.x - root.implicitHeight / 6; 
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

            implicitWidth: parent.width - root.handle.x - root.handle.implicitWidth - root.implicitHeight / 6;

            color: Colours.foregroundDark;
        }
    }

    handle: Rectangle {
        x: root.visualPosition * root.availableWidth - implicitWidth / 2;

        implicitWidth: 5;
        implicitHeight: 15;
    }
}
