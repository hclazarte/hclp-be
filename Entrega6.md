### Detalles sobre cómo se implementaron los modelos, vistas, autenticación y seguridad

#### Modelos
Los modelos en la aplicación siguen el patrón de arquitectura MVC (Modelo-Vista-Controlador) proporcionado por Ruby on Rails (RoR). Los modelos representan las entidades de la base de datos y gestionan la lógica de negocio y validación de datos. Entre los modelos principales se encuentran `Profile`, `Product`, `Order` y `OrderItem`, cada uno asociado a tablas en la base de datos Oracle.

- **Profile**: Representa a los usuarios en el sistema, gestionando atributos como nombre, email, teléfono, y dirección. Se utiliza `has_secure_password` para gestionar la autenticación a través de bcrypt, lo que permite almacenar contraseñas de manera segura en la base de datos.
- **Product**: Almacena información sobre los productos disponibles en la tienda, con atributos como nombre, descripción, precio y stock.
- **Order y OrderItem**: Gestionan las órdenes de compra y sus detalles. `Order` tiene una relación `has_many` con `OrderItem`, lo que permite almacenar múltiples productos en una sola orden. Los productos en el inventario se ajustan automáticamente cuando se realiza una compra, descontando las cantidades solicitadas en los pedidos.

#### Controladores y Vistas (API)
En esta aplicación, el backend está diseñado como una API Restful, lo que significa que no se utilizan vistas HTML tradicionales. En su lugar, los controladores responden a las solicitudes HTTP con datos JSON.

- **Controladores**: Los controladores gestionan las solicitudes entrantes, interactúan con los modelos y devuelven respuestas en formato JSON. Por ejemplo, `ProductsController` maneja las operaciones CRUD (Crear, Leer, Actualizar, Eliminar) sobre productos, y `OrdersController` gestiona las operaciones relacionadas con las órdenes.
- **Vistas**: Dado que es una API, las "vistas" son las representaciones JSON de los objetos devueltos por los controladores. Rails facilita la serialización de los objetos para responder con datos estructurados.

#### Autenticación
La autenticación en la aplicación se implementó mediante **Doorkeeper**, una gema de OAuth 2.0 que gestiona tokens de acceso para la autenticación de los usuarios. Se utiliza el flujo de "password grant" para obtener tokens cuando los usuarios ingresan sus credenciales.

- **Autenticación del usuario**: Cuando un usuario inicia sesión, el sistema genera un token de acceso que el cliente debe incluir en las solicitudes siguientes para interactuar con los recursos protegidos. Esto se implementa en todos los endpoints de la API que requieren que el usuario esté autenticado.
- **Seguridad de contraseñas**: Las contraseñas de los usuarios no se almacenan en texto plano. En su lugar, se utiliza `has_secure_password` para gestionar el hashing de las contraseñas mediante bcrypt, asegurando que se mantengan seguras en la base de datos.

#### Seguridad
La seguridad de la aplicación se centra en proteger los datos y asegurarse de que solo los usuarios autenticados tengan acceso a recursos sensibles.

- **Autorización mediante tokens**: El uso de OAuth 2.0 y Doorkeeper garantiza que solo los usuarios autenticados y autorizados puedan acceder a ciertos endpoints. Los tokens tienen una vida limitada, lo que minimiza el riesgo de que un token comprometido pueda ser utilizado indefinidamente.
- **Filtros de controladores**: Se implementan filtros como `before_action :doorkeeper_authorize!` para asegurarse de que solo los usuarios autenticados puedan acceder a ciertos controladores o acciones.
- **Validaciones**: Se han añadido validaciones tanto a nivel de base de datos como en los modelos para garantizar la integridad de los datos, evitando, por ejemplo, que se creen órdenes sin productos.

Este enfoque asegura que la aplicación siga principios sólidos de seguridad y buenas prácticas en la gestión de datos sensibles, como la autenticación y la protección de recursos.