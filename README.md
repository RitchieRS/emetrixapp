# EMETRIX APP
El proyecto de Emetrix consta de una app que permite al usuario guardar un registro de actividades determinadas en el almacenamienot local del dispositivo, para despues 
subirlas a la bd en la red. 

### Arquitectura

Este proyecto está hecho con la arquitectura MVVC con DDD (Modelo Vista - Vista Controlador. Con Domain Driven Design) para Flutter.

- Repository
- Service
- Provider
- Controller
- Screen

| Capa | Función |
| ------ | ------ |
| Repository | Se encarga de géstionar todas las comunicaciones por peticiones http con los servicios que se le conecten. |
| Service | Se encarga de géstionar toda la lógica de negocio del modulo. Ej. Si es módulo de Pérfil. El service se encarga de pasarle toda la informacion que viene del Repository, como se requiera, al controller.
| Provider | Se encarga de dar la referencia al controller. Provee la instancia del Service al controller.|
| Controller | Se encarga de administrar toda la logica visual del screen. Le pasa toda la informacion que viene del service al screen. Ej. Muestra cuadros de Diálogo, Modales etc. |
| Screen | Se encarga de mostrar toda la pantalla del módulo.  |

### Funcionalidad

La funcionalidad principal de emetrix es el poder crear formularios dinámicos (sondeos). La validación de esta función es en base a una matríz, un par de listados se iteran y se comprueban los indices de las listas para identificar las preguntas con las respuestas dinamicamente. Esto permite la identificacion de cada pregunta con su respuesta si el usuario ingresa datos, si no se guarda un valor (null). 


### Info Versionamiento

- Si se desea cambiar la versión de la app, ir a:
lib/core/global/config.dart

- Instucción para cambiar ícono
flutter pub run flutter_launcher_icons

- Usuario de prueba: gpoevogto
Contraseña: wer


 Versón de Flutter
• Flutter 3.13.2 
• Dart 3.1.0 
• App Version 1.0.0