pragma Singleton

import Quickshell;
import Quickshell.Hyprland;
import Quickshell.Io;
import QtQuick;
import "../";

Singleton {
    id: root;

    readonly property var options: ["lock", "reboot", "suspend", "hibernate", "logout", "shutdown"];
    property string uptimeText;
    property alias uptimeProc: uptimeProc;
    property alias uptimeTimer: uptimeTimer;

    function handlePowerSelection(choice) {
        var openDsp = "hl.dsp.exec_cmd(\"";
        var closeDsp = "\")";

        function exec(cmd) {
            Hyprland.dispatch(`hl.dsp.exec_cmd("${cmd}")`);
        }

        switch(options[choice]) {
            case "lock":
                console.log(options[choice]);
                break;
            case "reboot":
                exec("systemctl reboot");
                break;
            case "suspend":
                exec("systemctl suspend");
                break;
            case "hibernate":
                exec("systemctl hibernate");
                break;
            case "logout":
                exec("hyprshutdown");
                break;
            case "shutdown":
                exec("systemctl poweroff");
                break;
        }
    }

    Process {
        id: uptimeProc;
        command: ["uptime"];
        running: false;

        stdout: SplitParser {
            onRead: data => {
                console.log("hi");
                const match = data.match(/up\s+(.*?),\s+\d+\s+users?,/);
                console.log(match);
                if (match) {
                    root.uptimeText = match[1].trim();
                }
            }
        }
    }

    Timer {
        id: uptimeTimer;
        interval: 60000;
        running: false;
        repeat: false;

        onTriggered: uptimeProc.running = true;
    }

}
