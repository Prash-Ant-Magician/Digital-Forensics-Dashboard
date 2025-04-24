import sys
import os
from PyQt6.QtGui import QGuiApplication
from PyQt6.QtQml import QQmlApplicationEngine
from PyQt6.QtCore import QObject, pyqtSignal, pyqtSlot, QTimer

class HeatmapBackend(QObject):
    heatmapUpdated = pyqtSignal(list)

    def __init__(self):
        super().__init__()
        self._heatmap = [0.0] * 24
        self.mock_entries = self.generate_mock_data()

        # Simulate backend scanning on app load
        QTimer.singleShot(1500, self.simulateHeatmapFeed)

    def generate_mock_data(self):
        # Simulated list of entries with timestamp-like strings
        from random import randint
        return [{"time": f"{randint(0,23):02}:00:00"} for _ in range(200)]

    def generate_heatmap_data(self, entries):
        heatmap = [0] * 24
        for entry in entries:
            try:
                hour = int(entry["time"].split(":")[0])
                heatmap[hour] += 1
            except:
                continue

        max_val = max(heatmap) or 1
        return [round(h / max_val, 2) for h in heatmap]

    @pyqtSlot(list)
    def updateHeatmap(self, entries):
        self._heatmap = self.generate_heatmap_data(entries)
        self.heatmapUpdated.emit(self._heatmap)

    def simulateHeatmapFeed(self):
        self.updateHeatmap(self.mock_entries)

if __name__ == '__main__':
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    # Register and expose HeatmapBackend
    heatmapBackend = HeatmapBackend()
    engine.rootContext().setContextProperty("HeatmapBackend", heatmapBackend)

    # Load the QML UI
    qml_file = os.path.join(os.path.dirname(__file__), "qml", "AppWindow.qml")
    engine.load(qml_file)

    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec())
// Heatmap Clock
