#pragma once

#include <QObject>
#include <QQmlApplicationEngine>
#include <QUrl>

/**
 * @class QMLApplication
 * @brief Manages the initialization, loading, and execution of the QML engine.
 *
 * This class wraps @c QQmlApplicationEngine to simplify loading QML files
 * and handling the application execution loop. It provides methods to load
 * from local paths or URLs and includes fallback logic to ensures a
 * root object is loaded before execution.
 */
class QMLApplication: public QObject
{
        Q_OBJECT

    public:
        /**
         * @brief Constructs a QMLApplication object.
         * @param parent The parent QObject, or nullptr.
         */
        explicit QMLApplication(QObject* parent = nullptr);

        /**
         * @brief Destroys the QMLApplication object.
         */
        ~QMLApplication() override = default;

        /**
         * @brief Loads a QML file from a specific URL.
         * @param url The QUrl of the QML file to load.
         */
        auto load(const QUrl& url) -> void;

        /**
         * @brief Loads a QML file from a local filesystem path.
         * @param file_path The string path to the file.
         */
        auto load(const QString& file_path) -> void;

        /**
         * @brief Starts the application execution loop.
         *
         * Checks if a root object has been loaded. If not, it attempts to load
         * the default entry point ("qrc:/QML/main.qml").
         *
         * @return The application exit code produced by @c QCoreApplication::exec().
         */
        auto exec() -> int;

        /**
         * @brief Provides access to the internal QML engine.
         *
         * Useful for exposing C++ context properties to QML before loading.
         *
         * @return A pointer to the internal QQmlApplicationEngine.
         */
        [[nodiscard]] auto engine() -> QQmlApplicationEngine*;

        /**
         * @brief Provides read-only access to the internal QML engine (const overload).
         * @return A const pointer to the internal QQmlApplicationEngine.
         */
        [[nodiscard]] auto engine() const -> const QQmlApplicationEngine*;

    private:
        QQmlApplicationEngine m_engine;
};
