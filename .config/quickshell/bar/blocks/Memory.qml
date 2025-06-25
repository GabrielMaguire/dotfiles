import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import QtQuick.Layouts
import "../"

BarBlock {
  id: text
  content: RowLayout {
    spacing: 4

    Image {
      id: icon
      source: "/run/current-system/sw/share/icons/Chicago95/apps/32/hwinfo.png"
      sourceSize.width: 20
      sourceSize.height: 20
    }

    BarText {
      text: `${usedMem}%`
    }
  }

  property real usedMem

  Process {
    id: memProc
    command: ["sh", "-c", "free | grep Mem | awk '{print $3/$2 * 100.0}'"]
    running: true

    stdout: SplitParser {
      onRead: data => usedMem = Math.floor(data)
    }
  }

  Timer {
    interval: 2000
    running: true
    repeat: true
    onTriggered: memProc.running = true
  }
}
