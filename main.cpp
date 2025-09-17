#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "ManualTrackData.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    ManualTrackData manualTrackData;
    engine.rootContext()->setContextProperty("manualTrackData", &manualTrackData);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    engine.loadFromModule("ClassificationDataModel", "Main");

    return app.exec();
}
