pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root;

    property var musicData: {
        "player": "spotify",
        "title": "",
        "artist": "",
        "album": "",
        "length": 0,
        "pauseStat": "Paused",
        "loopStat": "None",
        "shuffleStat": "false",
    };
    property int progress: 0;

    Process {
        id: metaDataProc;

        command: ["playerctl",
                  "--follow",
                  "-p",
                  root.musicData.player,
                  "metadata",
                  "--format",
                  "{{title}};{{artist}};{{album}};{{mpris:length}};{{status}};{{shuffle}};{{loop}}"];
        running: true;

        stdout: SplitParser {
            onRead: data => {
                var info = data.split(";");
                root.musicData = {
                    title: info[0],
                    artist: info[1],
                    album: info[2],
                    length: Math.round(info[3] / 1000000),
                    pauseStat: info[4],
                    shuffleStat: info[5],
                    loopStat: info[6],
                };
            }
        }
    }

    Process {
        id: posProc;

        command : ["playerctl",
                   "-p",
                   root.musicData.player,
                   "position"];

        running: true;
        stdout: SplitParser {
            onRead: data => {
                root.progress = Math.round(parseFloat(data));
            }
        }
    }

    Timer {
        interval: 500;
        repeat: true;
        running: true;
        onTriggered: posProc.running = true;
    }
}
