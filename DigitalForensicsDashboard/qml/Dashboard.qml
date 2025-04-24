import QtQuick 6.4
import QtQuick.Controls 6.4
import QtQuick.Layouts 1.15
import QtQuick.Shapes
import "../components"

Item {
    id: dashboard
    anchors.fill: parent
    property alias resultsModel: resultsList.model

    ColumnLayout {
        anchors.fill: parent
        spacing: 12

        // 🔹 Top Bar — Scan Controls
        Rectangle {
            height: 70
            Layout.fillWidth: true
            color: "#141414"
            radius: 12
            border.color: "#222"

            RowLayout {
                anchors.fill: parent
                anchors.margins: 16
                spacing: 12

                TextField {
                    id: pathInput
                    placeholderText: "Enter browser DB path..."
                    color: "#fff"
                    font.pixelSize: 14
                    Layout.fillWidth: true
                    background: Rectangle {
                        color: "#1f1f1f"
                        radius: 10
                    }
                }

                ComboBox {
                    id: threatSelector
                    model: ["all", "malware", "phishing", "piracy", "adult"]
                    Layout.preferredWidth: 160
                    font.pixelSize: 13
                }

                Button {
                    text: "Scan"
                    Layout.preferredWidth: 100
                    onClicked: {
                        root.triggerScan(pathInput.text)
                    }
                }

                Button {
                    text: "Download Report"
                    Layout.preferredWidth: 160
                    onClicked: {
                        root.downloadReport(JSON.stringify(dashboard.resultsModel, null, 2))
                    }
                }
            }
        }

        // 🔹 Suspicion Level Meter
        SuspicionMeter {
            Layout.fillWidth: true
            height: 24
            level: root.suspicionLevel
        }

        // 🔹 Live Heatmap Timeline
        HeatmapClock {
            Layout.fillWidth: true
            height: 120
        }

        // 🔹 Scan Results List
        ListView {
            id: resultsList
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            spacing: 6
            delegate: ScanResultItem {}
        }
    }
}
// Main dashboard view
