import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import QtQuick.Effects;


Item {
    id: root;
    property int width;
    property int height;
    property int radius;

    Image {
        id: image;
        source: '/home/david/hdd/Images/Code Award.png';

        width: root.width;
        height: root.height;
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
}
