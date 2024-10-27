# Proyecto eCommerce Interactivo y Responsivo - Backend

[Puede verse aquí](https://hclp.online/)

Este proyecto es el backend para la maqueta y prototipo inicial de una plataforma de eCommerce. La implementación se ha realizado utilizando Ruby on Rails para proporcionar una API Restful que soporte las funcionalidades del frontend. La base de datos utilizada es ORACLE.

## Información del Curso

### Curso 1: PROGRAMMING THE INTERNET (CSE642)
- **Universidad:** Broward International University
- **Maestría:** Ciencias de Ingeniería de Software Informático
- **Tarea:** Desarrollo del Backend para la Plataforma eCommerce. Implementación de una API Restful utilizando Ruby on Rails.
- **Profesor:** PHD Cristian Gabriel Zambrano Vega
- **Alumno:** Ing. Héctor Cristóbal Lazarte

### Curso 2: OBJECT-ORIENTED PROGRAMMING (CSE641)
- **Universidad:** Broward International University
- **Maestría:** Ciencias de Ingeniería de Software Informático
- **Tarea:** Implementación orientada a objetos de la plataforma eCommerce. Desarrollar clases y métodos en Ruby para una estructura orientada a objetos.
- **Profesor:** PHD Cristian Gabriel Zambrano Vega
- **Alumno:** Ing. Héctor Cristóbal Lazarte

## Descripción del Proyecto

El objetivo de este proyecto es desarrollar el backend para una plataforma eCommerce, utilizando Ruby on Rails para construir una API Restful. Este backend proporcionará los servicios necesarios para soportar la interfaz de usuario interactiva y responsiva desarrollada en el frontend.

- **Ruby on Rails**: Para la construcción de la API Restful.
- **ORACLE**: Para la base de datos.

## Modelos de la Aplicación

### Perfil de Usuario (`Profile`)
Almacena la información del usuario, incluyendo:
- **full_name**: Nombre completo del usuario.
- **email**: Dirección de correo del usuario.
- **user_role**: Rol del usuario en la plataforma (por ejemplo, cliente o administrador).
- **preferencias de notificación**: Como `prefers_email`, `prefers_sms`, `prefers_in_app`.

### Pedido (`Order`)
Representa un pedido realizado por el usuario:
- **profile_id**: Referencia al perfil del usuario.
- **status**: Estado del pedido (por ejemplo, "pendiente", "completado").
- **total**: Total del pedido.
- **date**: Fecha del pedido.

### Productos Relacionados (`RelatedProducts`)
Modelo para representar productos relacionados con un producto principal:
- **product_id**: Producto principal.
- **related_product_id**: Producto relacionado.
- **relationship_type**: Tipo de relación (por ejemplo, "Relacionado").

### Producto (`Product`)
Almacena la información de cada producto:
- **name**: Nombre del producto.
- **description**: Descripción detallada del producto.
- **price**: Precio.
- **stock**: Cantidad en inventario.
- **category**: Categoría del producto.
- **discount**: Descuento aplicado (si corresponde).
- **imágenes**: Relación con `ProductImages`.

### Imágenes de Productos (`ProductImages`)
Contiene las imágenes asociadas a un producto:
- **product_id**: Relación con el producto.
- **image_url**: URL de la imagen.

### Carrito de Compras (`Cart`) y Artículos del Carrito (`CartItems`)
Permite al usuario seleccionar productos antes de realizar un pedido:
- **Cart**: Representa el carrito de un usuario (con `profile_id` y `status`).
- **CartItems**: Contiene los productos en el carrito, con `product_id` y `quantity`.

### Pago (`Payment`)
Información sobre el pago de un pedido:
- **order_id**: Relación con el pedido.
- **method**: Método de pago (tarjeta de crédito, PayPal, etc.).
- **status**: Estado del pago.
- **amount**: Monto del pago.

### Envío (`Shipment`)
Información del envío de un pedido:
- **order_id**: Relación con el pedido.
- **address**: Dirección completa de entrega.
- **status**: Estado del envío.
- **tracking_number**: Número de seguimiento.

### Notificaciones (`Notification`)
Envía notificaciones al usuario:
- **profile_id**: Usuario al que se notifica.
- **message**: Contenido de la notificación.
- **delivery_method**: Método de entrega (in_app, email, SMS).
- **status**: Estado de la notificación.

### Solicitudes de Devolución (`ReturnRequests`)
Permite gestionar devoluciones de productos:
- **profile_id**: Usuario que solicita la devolución.
- **order_id**: Pedido asociado a la solicitud.
- **product_id**: Producto a devolver.
- **reason**: Motivo de la devolución.
- **status**: Estado de la solicitud.

## Instalación y Configuración

### Requisitos Previos
- Tener instalado **Ruby on Rails** y **Oracle** para la base de datos.

### Pasos de Instalación

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


