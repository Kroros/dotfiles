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
        "progress": 0,
        "pauseStat": "Paused",
        "loopStat": "None",
        "shuffleStat": "false",
        "albumArt": "",
    };

    Process {
        id: metaDataProc;

        command: ["playerctl",
                  "--follow",
                  "-p",
                  root.musicData.player,
                  "metadata",
                  "--format",
                  "{{title}};{{artist}};{{album}};{{mpris:length}};{{position}};{{status}};{{shuffle}};{{loop}};{{mpris:artUrl}}"];
        running: true;

        stdout: SplitParser {
            onRead: data => {
                var info = data.split(";");
                root.musicData = {
                    title: info[0],
                    artist: info[1],
                    album: info[2],
                    length: Math.round(info[3] / 1000000),
                    progress: Math.round(info[4] / 1000000),
                    pauseStat: info[5],
                    shuffleStat: info[6],
                    loopStat: info[7],
                    albumArt: info[8],
                };
            }
        }
    }
}
