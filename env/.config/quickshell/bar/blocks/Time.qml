import QtQuick
import QtQuick.Layouts
import "../"

BarBlock {
  property string time;

  id: text
  content: RowLayout {
    Image {
      id: icon
      source: "/run/current-system/sw/share/icons/Chicago95/apps/16/clock.png"
      sourceSize.width: 16
      sourceSize.height: 16
    }

    BarText {
      symbolText: `${Datetime.time}`
    }
  }
}

