pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  property string time;
  property string date;

  Process {
    id: dateProc
    command: ["date", "+%b %e|%r"]
    running: true

    stdout: SplitParser {
      onRead: data => {
        [date, time] = data.split("|")
      }
    }
  }

  Timer {
    interval: 1000
    running: true
    repeat: true
    onTriggered: dateProc.running = true
  }
}

