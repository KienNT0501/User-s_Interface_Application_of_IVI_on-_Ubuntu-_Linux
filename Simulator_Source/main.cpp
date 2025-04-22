#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "climate.h"
#include <QDBusError>
#include <QDebug>
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    Climate climate ;
    QDBusConnection bus = QDBusConnection::sessionBus();
    if (!bus.registerService("com.DbusService")) {
        qFatal("❌ Failed to register D-Bus service: %s", qPrintable(bus.lastError().message()));
    }else {
        qDebug() << "✅ Successfully registered D-Bus service!";
    }

    if (!bus.registerObject("/Climate", &climate, QDBusConnection::ExportAllSlots | QDBusConnection::ExportAllSignals)) {
        qFatal("❌ Failed to register D-Bus object.");
    } else {
        qDebug() << "✅ Successfully registered D-Bus object!";
    }
    engine.rootContext()->setContextProperty("climated", &climate);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);
    return app.exec();
}
