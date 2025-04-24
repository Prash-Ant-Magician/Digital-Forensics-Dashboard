import sys
import os
from PyQt6.QtGui import QGuiApplication
from PyQt6.QtQml import QQmlApplicationEngine
from PyQt6.QtCore import QObject, pyqtSignal, pyqtSlot

class HeatmapBackend(QObject):
    heatmapUpdated = pyqtSignal(list)

    def __init__(self):
        super().__init__()
        self._heatmap = [0.0] * 24

    @pyqtSlot(list)
    def updateHeatmap(self, entries):
        heatmap = [0] * 24
        for entry in entries:
            try:
                hour = int(entry["time"].split(":")[0])
                heatmap[hour] += 1
            except:
                continue

        max_val = max(heatmap) or 1
        self._heatmap = [round(h / max_val, 2) for h in heatmap]
        self.heatmapUpdated.emit(self._heatmap)

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
