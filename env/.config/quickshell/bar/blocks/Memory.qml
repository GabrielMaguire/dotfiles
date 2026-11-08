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
      text: usedMem
    }
  }

  property string usedMem

  Process {
    id: memProc
    command: ["/home/gabriel/dev/sys_cmds/memory_used"]
    running: true

    stdout: SplitParser {
      onRead: data => usedMem = data
    }
  }

  Timer {
    interval: 2000
    running: true
    repeat: true
    onTriggered: memProc.running = true
  }
}
