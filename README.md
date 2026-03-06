# 🎥 🎬 Movie Technical Test
# Flutter Application 

Es una aplicación desarrollada en **Flutter** que consume la API TMDB de películas populares y permite visualizar detalles de cada película. 
La aplicación incluye manejo de estados, arquitectura limpia, ejecución offline, autenticación básica y pruebas unitarias.

# Descripción general del proyecto

La aplicación permite:

- Iniciar sesión mediante un formulario con validación.
- Consultar una lista de **películas populares** desde una API externa.
- Visualizar las películas en un **carrusel horizontal**.
- Navegar a una pantalla de **detalle con animación de transición**.
- Manejar estados de **carga, error y contenido**.
- Ejecutarse en **modo offline mostrando datos cacheados**.
- Detectar cambios de conectividad y permitir **reintento o sincronización**.
- Acceder a un **perfil/configuración** con opciones de tema y logout.

---

# Arquitectura aplicada

Para estructurar el proyecto decidí utilizar Clean Architecture porque permite separar responsabilidades entre capas. Separé la lógica de negocio de la capa de presentación. 
En la capa domain definí las entidades y los casos de uso, mientras que la capa data maneja el consumo del API y la transformación de modelos. 
Esto permite que la lógica de negocio no dependa de la UI ni de la implementación del datasource. 

**Presentation**
- UI (Screens, Widgets)
- Gestion de estado con Cubit

**Domain** 
- Entidades
- Casos de uso 
- Reglas de negocio 

**Data**
- Modelos
- Repositorios
- DataSources (Consumo de API y cache)

# Gestión de estados
Utilicé flutter_bloc (Cubit) para manejar los estados de la aplicación. 

- HomeInitial
- HomeLoading
- HomeLoaded
- HomeError 

Esto permite manejar de forma clara los estados de carga, error y contenido. 

# Consumo de API
Opté por usar la API de TMDB ( The Movie DataBase), la cual permite obtener: 

- películas populares
- información detallada
- imágenes y recursos visuales

Elegí esta API porque es ampliamente conocida y utilizada, tiene muy buena documentación y ofrece los recursos visuales completos que requería para completar esta prueba. 

# Estrategia Offline

La aplicación soporta su ejecución sin conexión mediante:
- Detección de conectividad usando **connectivity_plus**
- Persistencia local con **shared_preferences**
- Cuando no hay internet se muestran datos cacheados
- Se indica visualmente con un banner de color rojo cuando no se cuenta con conexión a internet
- Permite reintentar la sincronización cuando se restablece la conexión.

# Flujo de autenticación 

Se implementó una patalla de login con: 

- Validación de usuario (usuario vacio)
- Validación de contraseña (mínimo 8 caracteres, una mayúscula, un número y un caracter especial)

Una vez autenticado se accede a la pantalla principal de la aplicación

# Funcionalidades principales

- Listado de peliculas populares
- Carrusel horizontal de peliculas
- Pantalla de detalle con animación Hero
- Manejo de carga, error y contenido
- Modo offline 
- Perfil de usuario
- Cambio de tema claro, oscuro y automático
- Logout
- Información de versión de la aplicación

# Navegación 

Utilicé GoRouter, que permite navegación declarativa, manejo sencillo de rutas y paso de datos entre pantallas, por ejemplo, de Home a Movie Detail usando **Hero** oara una transición visual. 

# Pruebas unitarias
Implementé pruebas para

- **Cubit** -> Verifica estado de carga, estado de éxito y estado de error
- **Caso de uso** -> Valida la lógica del caso de uso
- **Widget** -> Verifica el renderizado de campos y valida el formulario

Utilizando flutter_test, bloc_test, mocktail 

# Tecnologías utilizadas 
- Flutter
- Dio
- Flutter Bloc (Cubit)
- GoRouter
- Connectivity Plus
- Shared Preferences

# Posibles mejoras futuras
- Usar una base de datos local como Isar
- Mejorar el manejo de errores de red
- Paginación de listado de películas
- Mejorar la cobertura de las pruebas unitarias

# Como ejecutar el proyecto 
- Clonar el repositorio
git clone <repo>

- Instalar las dependencias
flutter pub get 

- Ejecutar la aplicación 
flutter run 

# Autor 

Proyecto desarrollado como parte de una **prueba técnica de Flutter** 
**Eimy Quintero**
