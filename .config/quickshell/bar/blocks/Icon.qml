import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
// import Qt5Compat.GraphicalEffects
import "../"
import "root:/"

BarBlock {
  id: root
  Layout.preferredWidth: 40

  content: BarText {
    text: ""
    pointSize: 17
    anchors.horizontalCenterOffset: -2
  }
  // content: IconImage {
  //   id: theicon
  //   visible: false
  //   anchors.centerIn: parent
  //   source: "image://icon/extra-nixos"
  //   implicitSize: 20
  // }
  // DropShadow {
  //   anchors.fill: parent
  //   horizontalOffset: 1
  //   verticalOffset: 1
  //   radius: 6.0
  //   samples: 20
  //   color: "#000000"
  //   source: parent.content
  // }
  // IconImage {
  //   anchors.centerIn: parent
  //   source: "image://icon/extra-nixos"
  //   implicitSize: 20
  // }

  Image {
    anchors.fill: parent
    source: mouseArea.containsMouse
        ? "../images/" + Theme.get.iconPressedColor + ".png"
        : "../images/" + Theme.get.iconColor + ".png";
    visible: true
    z: -1
  }

  color: "transparent"

  Process {
    id: launcher
    running: false
    command: [ "wofi", "--show", "drun" ]
  }

  onClicked: function() {
    launcher.running = true
  }
}

