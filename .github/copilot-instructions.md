# Project Overview

This project is a **C++ Qt Quick application** establishing a modular architecture for high-performance user interfaces using **QML** with a robust **C++ backend**.  
It supports cross-platform builds (Windows, Linux, macOS) and provides optional Docker integration.  
The project is split into a main application (`QML_Project`) and an optional test project (`QML_Project_Tests`), both managed with **CMake**.

## Folder Structure

- `/QML_Project`
  - `/Headers/QtQuickTemplate`
    - `/Views` – C++ backing classes for UI extensions (custom `QQuickItem`s, etc.)
    - `/Services` – service layer (e.g., logging, file I/O, networking)
    - `/Models` – data models (subclasses of `QAbstractListModel`, etc.)
    - `/Controllers` – application logic and context properties
  - `/Sources/QtQuickTemplate` – implementation files (mirroring `Headers/QtQuickTemplate`)
  - `/QML` – QML frontend files
    - `/Views` – Main logic-heavy views
    - `/Components` – Reusable QML components
  - `/Resources` – icons, translations, images, etc.
- `/QML_Project_Tests` – test project (headers, sources, third-party test dependencies)
- `/CMake` – shared CMake modules
- `/Configs` – clang-tidy, clang-format, Doxygen, etc.
- `/Scripts` – platform-specific build & deployment scripts
- `/Dockerfile` – Docker build configuration

## Libraries and Frameworks

- **C++20**
- **CMake** (minimum version 3.29)
- **Qt 6** (Core, Gui, Qml, Quick, QuickControls2, Widgets)
- Optional:
  - **clang-format** & **clang-tidy** for linting
  - **Doxygen** for documentation
  - **Docker** for containerized builds

## Coding Standards

- Use **snake_case** for variable and function names.
- Use **trailing return types** for all functions (e.g., `auto foo() -> int`).
- Only **one return per method**, at the end of the method.  
  - Exception: `void` methods must not use `return`.
- **Avoid** using `break` and `continue`.
- Use `[[nodiscard]]` on functions where ignoring the return value would be a logical error or make the function call meaningless.  
  - If `[[nodiscard]]` is added, the **Doxygen documentation must clearly describe the importance of the return value**.
- **Follow the defined folder structure:**  
  - `/QtQuickTemplate/Views` for UI-related C++ classes  
  - `/QtQuickTemplate/Services` for service layer code  
  - `/QtQuickTemplate/Models` for data models  
  - `/QtQuickTemplate/Controllers` for application logic  
- **Getter and setter naming convention:**  
  - Getter methods must always start with `get` (e.g., `get_value()`).  
  - Setter methods must always start with `set` (e.g., `set_value(int new_value)`).  

## Documentation Rules

- Always generate **Doxygen documentation** for both headers (`.h`) and implementation files (`.cpp`).  
- All documentation must be written **in English**.  
- **Any code change or addition (e.g., new class, method, parameter, or option) must always be accompanied by updated Doxygen documentation.**  
- When making changes, always show **exactly where documentation has been added, updated, or removed**, so that code and docs remain fully synchronized.  

## Build and Test Guidelines

- CMake options configure build type, test inclusion, sanitizers, and documentation generation.
- Tests live under `QML_Project_Tests` and mirror the structure of the main project.
- Coverage reports can be uploaded via external tools (e.g., Codecov) if configured.

## UI Guidelines

- The app uses **QML** for the frontend and **C++** for the backend.
- Maintain a **clean separation** between UI (QML) and logic (C++).
- Expose C++ functionality to QML via `Q_PROPERTY`, `Q_INVOKABLE`, or `QAbstractItemModel`.
- Resources such as icons and translations are loaded from the `/Resources` folder.
- Translations should be managed with `.ts` files and compiled via CMake targets (`_translations_update`, `_translations_compile`).
