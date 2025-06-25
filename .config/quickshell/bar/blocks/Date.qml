import QtQuick
import QtQuick.Layouts
import "../"

BarBlock {
  id: text
  content: RowLayout {
    Image {
      id: icon
      source: "/run/current-system/sw/share/icons/Chicago95/apps/32/calendar.png"
      sourceSize.width: 20
      sourceSize.height: 20
    }

    BarText {
      symbolText: `${Datetime.date}`
    }
  }
}

