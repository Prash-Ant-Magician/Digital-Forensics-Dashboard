import QtQuick 6.4
import QtQuick.Controls 6.4
import QtQuick.Layouts 1.15
import QtQuick.Window 6.4
import QtGraphicalEffects 1.15

Window {
    id: root
    width: 1280
    height: 800
    visible: true
    color: "transparent"
    flags: Qt.FramelessWindowHint | Qt.Window

    property alias mainView: dashboardLoader.item

    Rectangle {
        id: background
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#0d0d0d" }
            GradientStop { position: 1.0; color: "#121212" }
        }
    }

    Rectangle {
        id: glassFrame
        anchors.fill: parent
        color: "#10101080"
        radius: 20
        layer.enabled: true
        layer.effect: FastBlur {
            radius: 32
            source: background
        }
    }

    // Header bar (custom title bar)
    Rectangle {
        id: titleBar
        height: 50
        width: parent.width
        color: "#1a1a1a"
        anchors.top: parent.top
        MouseArea {
            anchors.fill: parent
            drag.target: root
        }

        RowLayout {
            anchors.fill: parent
            spacing: 10
            padding: 12

            Label {
                text: "🔍 Digital Forensics Dashboard"
                font.pixelSize: 18
                color: "#00ffff"
                Layout.alignment: Qt.AlignVCenter
            }

            Item { Layout.fillWidth: true }

            Button {
                text: "✖"
                background: Rectangle { color: "transparent" }
                onClicked: Qt.quit()
            }
        }
    }

    Loader {
        id: dashboardLoader
        anchors {
            top: titleBar.bottom
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }
        source: "Dashboard.qml"
    }

    // Optional: Overlay for particles/ambient effects
    // Just a stub for now — we’ll wire in real animations later
    Rectangle {
        id: ambientGlowOverlay
        anchors.fill: parent
        visible: true
        color: "#00ffff10"  // Soft neon teal glow
        z: -1
    }
}
// Window wrapper
