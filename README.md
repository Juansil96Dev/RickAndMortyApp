# 🧪 RickAndMortyApp

RickAndMortyApp es una aplicación iOS desarrollada en Swift que permite visualizar una lista de personajes de la popular serie animada **Rick and Morty**, integrando una API externa pública. Además, cuenta con un sistema básico de registro e inicio de sesión de usuarios, con almacenamiento local mediante Core Data.

---

## ✨ Características

- 🔐 Registro e inicio de sesión de usuario (persistencia local con Core Data).
- 📡 Consumo de la API pública [Rick and Morty API](https://rickandmortyapi.com/).
- 🧍‍♂️ Visualización de personajes en una grilla y búsqueda local.
- 🎯 Arquitectura limpia con **MVVM** (Model-View-ViewModel).
- 🧭 Navegación gestionada con el patrón **Coordinator**.
- 🧩 Uso de **Swift Package Manager (SPM)** para integrar librerías externas.
- 📱 Interfaz responsiva y moderna utilizando UIKit.

---

## 🧱 Arquitectura

- **MVVM**: Separa la lógica de negocio, lógica de presentación y la UI.
- **Coordinators**: Se usa para desacoplar la navegación de los `ViewControllers`.
- **Core Data**: Para persistencia de los usuarios registrados en el dispositivo local.
- **SPM**: Para gestionar dependencias y mantener el proyecto modular y limpio.

---

## 📦 Dependencias

El proyecto utiliza [Swift Package Manager (SPM)](https://swift.org/package-manager/) para la gestión de dependencias.

---
## 🔧 Requisitos

- Xcode 15 o superior
- iOS 13.0+
- Swift 4.2

