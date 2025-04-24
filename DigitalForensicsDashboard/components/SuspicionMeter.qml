import QtQuick 6.4
import QtQuick.Controls 6.4
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15

Item {
    id: meter
    property int level: 0 // 0 - 100
    width: parent.width
    height: 24

    Rectangle {
        id: baseBar
        anchors.fill: parent
        radius: height / 2
        color: "#1a1a1a"
        border.color: "#333"
        border.width: 1
    }

    Rectangle {
        id: progressBar
        width: baseBar.width * (level / 100)
        height: baseBar.height
        radius: height / 2
        color: Qt.rgba(1, 0, 0, 0.6)

        Behavior on width {
            NumberAnimation { duration: 500; easing.type: Easing.InOutQuad }
        }

        Glow {
            anchors.fill: progressBar
            radius: 16
            samples: 12
            color: "red"
            source: progressBar
        }
    }

    Text {
        anchors.centerIn: parent
        text: "Suspicion Level: " + level + "%"
        color: "#fff"
        font.pixelSize: 13
        font.bold: true
    }
}
// Suspicion Meter UI
