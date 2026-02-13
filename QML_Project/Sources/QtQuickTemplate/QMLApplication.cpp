/**
 * @file QmlApplication.cpp
 * @brief Implementation of the QMLApplication class.
 */

#include "QtQuickTemplate/QMLApplication.h"

#include <QApplication>
#include <QDebug>
#include <QQmlContext>
#include <QString>

/**
 * @brief Constructs a QMLApplication object with the given parent.
 *
 * @param parent The parent object.
 */
QMLApplication::QMLApplication(QObject* parent): QObject(parent) {}

/**
 * @brief Loads the QML file from the specified URL.
 *
 * @param url The URL of the QML file to load.
 */
auto QMLApplication::load(const QUrl& url) -> void
{
    m_engine.load(url);
}

/**
 * @brief Loads the QML file from the specified file path.
 *
 * wraps the path in a QUrl before loading.
 *
 * @param file_path The file path of the QML file to load.
 */
auto QMLApplication::load(const QString& file_path) -> void
{
    m_engine.load(QUrl::fromLocalFile(file_path));
}

/**
 * @brief Executes the QML application.
 *
 * This function ensures a root QML file is loaded. If the engine has no root objects
 * (meaning previous load calls failed or weren't made), it attempts to load the
 * default "qrc:/QML/main.qml".
 *
 * @return The exit code of the application.
 */
auto QMLApplication::exec() -> int
{
    int result = -1;

    // Check if anything was effectively loaded (root objects created)
    bool root_qml_file_loaded = !m_engine.rootObjects().isEmpty();

    if (!root_qml_file_loaded)
    {
        qDebug()
            << "[QMLApplication] No root objects. Attempting to load default: qrc:/QML/main.qml";
        m_engine.load(QUrl(QStringLiteral("qrc:/QML/main.qml")));
        root_qml_file_loaded = !m_engine.rootObjects().isEmpty();
    }

    if (root_qml_file_loaded)
    {
        qDebug() << "[QMLApplication] Starting application execution...";
        result = qApp->exec();
    }
    else
    {
        qCritical() << "[QMLApplication] Critical: Failed to load any QML file. Exiting.";
    }

    return result;
}

/**
 * @brief Provides access to the internal QML engine.
 * @return A pointer to the internal QQmlApplicationEngine.
 */
auto QMLApplication::engine() -> QQmlApplicationEngine*
{
    return &m_engine;
}

/**
 * @brief Provides read-only access to the internal QML engine.
 * @return A const pointer to the internal QQmlApplicationEngine.
 */
auto QMLApplication::engine() const -> const QQmlApplicationEngine*
{
    return &m_engine;
}
