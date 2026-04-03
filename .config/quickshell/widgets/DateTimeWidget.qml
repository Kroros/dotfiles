import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import "../widgetUtils"
import "../components"

ColumnLayout {
    spacing: 1

    implicitWidth: 100


    StyledText {
        Layout.alignment: Qt.AlignRight
        text: DateTime.date
        color: Colours.primary
        font.pixelSize: 16
    }
    StyledText {
        Layout.alignment: Qt.AlignRight
        text: DateTime.time
        color: Colours.primary
        font.pixelSize: 16
    }
    MouseArea {
        anchors.fill: parent;
        cursorShape: Qt.PointingHandCursor;

        onClicked: {
            Quickshell.execDetached(['bash', '~/.config/hypr/scripts/qs_manager.sh "Calendar"']);
        }
    }

    Process {
        id: toggleCalendar;
        command: ['bash',
                    '~/.config/hypr/scripts/qs_manager.sh "Calendar"'];
    }
}
