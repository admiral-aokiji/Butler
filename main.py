# This Python file uses the following encoding: utf-8
import sys
import os
import fitz
import json
from PySide2.QtGui import QGuiApplication, QImage
from PySide2.QtQml import QQmlApplicationEngine
from PySide2.QtCore import QObject, Slot, Signal, QUrl
#from PySide2.QtQuick import QQuickImageProvider


class ImportPdf:
    def __init__(self, path):
        self.path = ('//').join(path[8:].split('/'))
        self.file = fitz.open(self.path)

#class ImageGen(QQuickImageProvider):
#    def __init__(self):
#        super(ImageGen, self).__init__(QQuickImageProvider.Image)

#    def requestImage(self, *args, **kwargs):
#        qimg = QImage(120, 100, QImage.Format_RGBA8888)
#        qimg.fill('#ff0000')
#        global tnails
#        qimg = tnails[0]
#        print(qimg)
#        return qimg


pdfPath = ''


class MainWindow(QObject):
    def __init__(self):
        QObject.__init__(self)

    #Common Slots
    readFileName = Signal(str)

    # Resource Opener
    #--------------------------------
    addTopic = Signal(str)
    @Slot(str)
    def loadSections(self, jsonFile):
        with open(jsonFile, mode='r') as f:
            jsontxt = f.read()
            self.addTopic.emit(jsontxt)


    @Slot(str)
    def addSection(self, topicName, incPath):
        print(topicName, incPath)
        with open('json/folders.json', mode='r+') as f:
            res = {
            'name':topicName,
            'folderPath': incPath
            }
            print(res.name)
            ftext = json.loads(f.read())
            ftext['objects'].append(res)
            ftext = json.dumps(ftext)
            self.addTopic.emit(ftext)

    @Slot(str)
    def openFolder(self, fPath):
        path = os.path.realpath(fPath)
        os.startfile(path)

    # Question Paper Typer
    #--------------------------------
    readText = Signal(str)

    @Slot(str)
    def openFile(self, filePath):
        with open(QUrl(filePath).toLocalFile(), mode='r', encoding="utf-8") as f:
            fText = f.read()
        self.readText.emit(str(fText))

    # PDF Editor
    #--------------------------------
    pdfPages = Signal(int)
    readFileName= Signal(str)
    thumbNails = Signal(list)

    @Slot(str)
    def openPDF(self, filePath):
        tnails = []
        f = ImportPdf(filePath)
        global pdfPath
        pdfPath = filePath
        print(len(tnails))
        i = 0
        for page in f.file.pages():
            i += 1
            pix = page.get_pixmap()
            fmat = QImage.Format_RGBA8888 if pix.alpha else QImage.Format_RGB888
            pix.shrink(3)
            # check for width > 150, if yes, then make it 150 and decrease height by same ratio
            qtimg = QImage(pix.samples, pix.width, pix.height, pix.stride, fmat)
            tnails.append(qtimg)
            pix.writeImage("images/pdfEditor/thumbnails/page-%i.png" % i)
#            print(qtimg)
        print(len(tnails))
        self.thumbNails.emit(tnails)
        self.pdfPages.emit(f.file.page_count)
        f.file.close()
        self.readFileName.emit(str(filePath.split('/')[-1]))

    @Slot(str)
    def deleteByRange(self, start, end, savePath):
        f = ImportPdf(pdfPath)
        print(pdfPath)
        print('old', f.file.page_count)
        f.file.delete_pages(start, end)
        print('new', f.file.page_count)
        f.file.save('cut123456789.pdf')
        self.pdfPages.emit(f.page_count)
        f.file.close()


if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    # Get Context
    main = MainWindow()
    engine.rootContext().setContextProperty("backend", main)

    # Set App Extra Info
    app.setOrganizationName("Aokiji")
    app.setOrganizationDomain("N/A")

#    engine.addImageProvider("thumbnail", ImageGen())
    engine.load(os.path.join(os.path.dirname(__file__), "qml/main.qml"))

    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_())
