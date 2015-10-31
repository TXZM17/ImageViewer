import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2

ApplicationWindow {
    title: qsTr("Hello World")
    width: 640
    height: 480
    visible: true

    menuBar: MenuBar {
        Menu {
            title: "文件"
            MenuItem {
                text: "打开"
                onTriggered: {
                    fileDialog.open();
                }
            }
            MenuItem {
                text: "退出"
                onTriggered: Qt.quit();
            }
        }
    }

    BusyIndicator {
        id: busyIndicator;
        running: false;
        anchors.centerIn: parent;
        z: 2;
    }

    Image {
        id: imageView;
        source: "qrc:/姬野永远.png";
        asynchronous: true;
        cache: false;
        anchors.fill: parent;
        fillMode: Image.PreserveAspectFit;
        onStatusChanged: {
            if(imageView.status==Image.Loading){
                busyIndicator.running = true;
            }else if(imageView.status==Image.Ready){
                busyIndicator.running = false;
            }else if(imageView.status==Image.Error){
                busyIndicator.running = false;
                statusLabel.visible = true;
                filePath.text = filePath.text + "加载出现了问题";
            }
        }
    }

    MessageDialog {
        id: messageDialog
        title: qsTr("May I have your attention, please?")

        function show(caption) {
            messageDialog.text = caption;
            messageDialog.open();
        }
    }

    statusBar: Text{
        id: filePath;
        text: "未选择图片";
        color: "grey";
    }

    FileDialog {
        id: fileDialog;
        title: "请选择一个图片文件";
        folder: "file:///D:/media";
        nameFilters: ["Image file (*.jpg *.png *.jpeg *.gif)"];
        onAccepted: {
            imageView.source = fileDialog.fileUrl;
            var path = new String(fileDialog.fileUrl).slice(8);
            filePath.text = path;
        }
    }
}
