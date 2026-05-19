import Quickshell
import QtQuick
import Quickshell.Io

ShellRoot {
    id: root;
    
    property string activeWidget: "none";

    Bar {}

    IpcHandler {
        target: "main";

        function toggleWidget(name: string): void {
            root.activeWidget = (root.activeWidget === name) ? "none" : name;
        }

        function forceReload(): void {
            Quickshell.reload(true);
        }
    }

    Calendar {
        id: calendar;
        visible: root.activeWidget == "Calendar";
    }

    Music {
        id: mplayer;
        visible: root.activeWidget == "Music";
    }
}
