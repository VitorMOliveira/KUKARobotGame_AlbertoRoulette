#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QIcon>
#include <QQuickView>
#include "backend.h"
#include "kukagamecontrol.h"
#include "opencvimageprovider.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;


    const QUrl url(QStringLiteral("qrc:/qml/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    Backend *myBackend;
    myBackend = new Backend(0, &engine);
    OpencvImageProvider *liveImageProvider(new OpencvImageProvider);

    engine.rootContext()->setContextProperty(QStringLiteral("myBackend"), myBackend);
    engine.rootContext()->setContextProperty("liveImageProvider", liveImageProvider);

    engine.addImageProvider("live", liveImageProvider);

    QObject::connect(myBackend, &Backend::newImage, [&] (QImage image) {
       liveImageProvider->updateImage(image);
    });

    app.exec();
    return app.exec();
}
