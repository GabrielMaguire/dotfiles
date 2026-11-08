import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import "../"

BarBlock {
  id: text
  visible: Pipewire.ready

  content: RowLayout {
    Image {
      id: volumeImg
      source: "/run/current-system/sw/share/icons/Chicago95/status/32/audio-volume-high.png"
      sourceSize.width: 16
      sourceSize.height: 16
    }

    BarText {
      symbolText: `${volume}`
    }
  }

  property PwNode sink: Pipewire.defaultAudioSink
  property string volume: Pipewire.ready ? `${Math.floor(sink.audio.volume * 100)}%` : ""

  PwObjectTracker { objects: [ sink ] }
}

