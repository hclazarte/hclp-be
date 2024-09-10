1. **Explicación del uso de RoR y su arquitectura**:
   Ruby on Rails (RoR) es un framework basado en el patrón MVC (Modelo-Vista-Controlador), diseñado para crear aplicaciones web de manera eficiente. En esta arquitectura:
   
   - **Modelos** representan los datos y la lógica de negocio. En Rails, cada tabla en la base de datos se representa como un modelo, y cada instancia del modelo se corresponde con una fila en esa tabla.
   
   - **Vistas** son las plantillas que presentan los datos a los usuarios. Generan HTML o cualquier otro formato de salida basado en los datos del modelo.

   - **Controladores** gestionan la interacción del usuario, responden a las solicitudes HTTP y utilizan modelos para recuperar datos de las bases de datos. Luego, se renderiza la vista apropiada para mostrar la respuesta.

   Rails también utiliza convenciones sobre configuración, lo que reduce la necesidad de configuraciones manuales, haciendo el desarrollo más rápido y estructurado. Se aprovecha de herramientas como ActiveRecord para la abstracción de bases de datos, facilitando las consultas SQL a través de métodos Ruby.

2. **Detalles sobre la integración de las bases de datos SQL y NoSQL**:
   En el proyecto, se ha integrado tanto una base de datos SQL (como Oracle) como una base de datos NoSQL (MongoDB). Oracle se utiliza para almacenar datos transaccionales estructurados y relacionados, como los perfiles de usuario, productos y pedidos, mientras que MongoDB se emplea para almacenar datos no estructurados o semi-estructurados, como las estadísticas de uso del sistema.

   La integración de ambas bases de datos combina lo mejor de ambos mundos: 
   
   - **SQL (Oracle)** ofrece una estructura definida, integridad referencial y transacciones ACID, ideal para gestionar la lógica de negocio que involucra relaciones complejas y la consistencia de los datos.
   
   - **NoSQL (MongoDB)** es flexible y se utiliza para almacenar grandes volúmenes de datos, con un esquema más flexible. MongoDB es particularmente útil para manejar datos como logs de uso, que no requieren relaciones estrictas, pero sí una rápida escritura y lectura.

   Ambas bases de datos están conectadas mediante drivers específicos y se integran de forma transparente en el flujo de la aplicación RoR, permitiendo que RoR interactúe con ambas fuentes de datos según sea necesario.