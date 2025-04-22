#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QObject>
#include <QQmlContext>
#include "App/ASM4/playlistmodel.h"
#include "App/ASM4/player.h"
#include "App/ASM4/translator.h"
#include <QDBusConnection>
#include "App/Climate/climatemodel.h"
#include "applicationmodel.h"
#include "xmlreader.h"
#include "xmlwriter.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    ClimateModel climatec;
    Player controller;
    Translator translator;
    ApplicationModel appsModel;
    xmlReader xmlReader("applications.xml", appsModel);
    xmlWriter xmlWriter("applications.xml", appsModel);
    engine.rootContext()->setContextProperty("saveXML", &xmlWriter);
    engine.rootContext()->setContextProperty("climateModel", &climatec);
    engine.rootContext()->setContextProperty("appsModel", &appsModel);
    engine.rootContext()->setContextProperty("Playlist", controller.playlist);
    engine.rootContext()->setContextProperty("PlaylistModel", controller.playlistModel);
    engine.rootContext()->setContextProperty("player", &controller);
    engine.rootContext()->setContextProperty("Translator", &translator);

    qmlRegisterType<PlaylistModel>("myType.PlaylistModel", 1, 0, "MyPlayList");


    // Initialize ClimateWrapper and expose it to QML
    const QUrl url(QStringLiteral("qrc:/Home_Screen_QML/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    // 🔹 Move `emit` inside a `QTimer` to avoid calling it too early


    return app.exec();
}
