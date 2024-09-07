# Proyecto eCommerce Interactivo y Responsivo - Backend

[Puede verse aquí](https://hclp.online/)

Este proyecto es el backend para la maqueta y prototipo inicial de una plataforma de eCommerce. La implementación se ha realizado utilizando Ruby on Rails para proporcionar una API Restful que soporte las funcionalidades del frontend. La base de datos utilizada es ORACLE.

## Información del Curso

- **Universidad:** Broward International University
- **Maestría:** Ciencias de Ingeniería de Software Informático
- **Curso:** PROGRAMMING THE INTERNET (CSE642)
- **Tarea:** Desarrollo del Backend para la Plataforma eCommerce. Implementación de una API Restful utilizando Ruby on Rails.
- **Profesor:** PHD Cristian Gabriel Zambrano Vega
- **Alumno:** Ing. Héctor Cristóbal Lazarte

## Descripción del Proyecto

El objetivo de este proyecto es desarrollar el backend para una plataforma eCommerce, utilizando Ruby on Rails para construir una API Restful. Este backend proporcionará los servicios necesarios para soportar la interfaz de usuario interactiva y responsiva desarrollada en el frontend.

- **Ruby on Rails**: Para la construcción de la API Restful.
- **ORACLE**: Para la base de datos.

## Detalles de Implementación

### Modelos

Descripción de los modelos utilizados en el proyecto:

- **Profile**: Utilizado para almacenar información del usuario como nombre, email, etc. Relacionado con otros modelos como `Orders` para representar pedidos realizados por el usuario.
- **Order**: Representa un pedido, asociado a un `Profile` y contiene detalles como estado del pedido, total, y fecha.
- **RelatedProducts**: Modelo para representar productos relacionados a un producto principal.

### Vistas

Descripción de cómo se implementan las vistas y qué tecnologías se utilizan [Frontend](https://github.com/hclazarte/hclp-online).

### Autenticación

Detalles sobre cómo se implementa la autenticación:

- Utiliza `Doorkeeper` para OAuth 2.0, permitiendo autenticación segura y proporcionando tokens a los clientes.
- La configuración incluye scopes específicos para proteger los endpoints y asegurar que los tokens sean generados con los permisos correctos.

### Seguridad

Medidas de seguridad implementadas:

- Uso de `bcrypt` para hashing de contraseñas, asegurando que las contraseñas de los usuarios no se almacenen en texto plano.
- Configuración de políticas CORS para limitar los dominios que pueden interactuar con la API.
- Validaciones estrictas en los modelos para prevenir inyecciones SQL y otros ataques comunes.

## Instalación y Configuración

Sigue los siguientes pasos para configurar y ejecutar el backend localmente:

1. **Clonar el repositorio:**

   ```sh
   git clone https://github.com/hclazarte/hclp-be.git
   cd hclp-be

2. **Instalar Dependencias:**

   ```sh
   bundle install

3. **Configurar la Base de Datos:**

   ```sh
   rails db:create
   rails db:migrate

4. **Iniciar el Servidor:**

   ```sh
   rails server


