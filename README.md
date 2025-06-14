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

## 🚀 Instalación y ejecución

1. Clona este repositorio:

   ```bash
   git clone https://gitlab.com/tuusuario/rickandmortyapp.git
   cd rickandmortyapp
2. Abre el proyecto en Xcode:
    open RickAndMortyApp.xcodeproj
3. Espera a que se resuelvan las dependencias (SPM).
4. Ejecuta el proyecto en un simulador o dispositivo real.

## 🧪 Próximas mejoras

- Implementar autenticación real con backend remoto.
- Mejorar validación de formularios y mensajes de error.
- Agregar favoritos o filtros por especie/estado/género.
- Visualizacion de episodios y localidades.
- Tests unitarios y de integración.

## 👨‍💻 Autor

    Desarrollado por [Juan Silvino Gonzalez Agüero] – @jsgonzalez96.dev