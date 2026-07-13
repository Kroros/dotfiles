import Quickshell
import QtQuick
import Quickshell.Io

ShellRoot {
    id: root;
    
    property string activeWidget: "none";

    Bar {
        id: statusBar;
        vSize: 50;
    }

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

    Power {
        id: powerMenu;
        visible: root.activeWidget == "Power";
    }
}
