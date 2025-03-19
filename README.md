# Backend del Sistema de Gestión de Citas Médicas

Este es el backend del **Sistema de Gestión de Citas Médicas**, desarrollado en **Ruby on Rails** con **Oracle** como base de datos.

## Requisitos Previos

Asegúrate de tener instalados los siguientes paquetes antes de iniciar el proyecto:

- **Ruby** (versión recomendada: 3.2.3)
- **Rails** (versión recomendada: 7.2.2.1)
- **Bundler** (`gem install bundler`)
- **Base de datos Oracle** con las credenciales configuradas
- **Docker** (opcional, si deseas usar contenedores para la base de datos)

## Instalación

Sigue estos pasos para configurar y ejecutar el backend:

1. **Clonar el repositorio**

```bash
  git clone https://github.com/hclazarte/hclp-be.git
```

2. **Instalar las dependencias**

```bash
  bundle install
```

3. **Configurar la base de datos**
   Modifica el archivo `config/database.yml` para apuntar a la base de datos Oracle:

```yaml
  default: &default
    adapter: oracle_enhanced
    username: tu_usuario
    password: tu_contraseña
    host: tu_host
    database: tu_basededatos

  development:
    <<: *default
```

4. **Ejecutar las migraciones**

```bash
  rails db:create db:migrate
```

5. **Iniciar el servidor**

```bash
  rails server
```

El backend estará disponible en **`http://localhost:3001`**.

## API Endpoints

Los principales endpoints disponibles son:

### Autenticación (Doorkeeper)

- `POST /oauth/token` → Obtiene un token de acceso.
- `POST /oauth/revoke` → Revoca un token de acceso.

### Pacientes

- `GET /pacientes` → Lista todos los pacientes.
- `POST /pacientes` → Crea un nuevo paciente.
- `GET /pacientes/{id}` → Obtiene un paciente por ID.
- `PUT /pacientes/{id}` → Modifica un paciente.
- `DELETE /pacientes/{id}` → Elimina un paciente.

### Médicos

- `GET /medicos` → Lista todos los médicos.
- `POST /medicos` → Registra un nuevo médico.
- `GET /medicos/{id}` → Obtiene un médico por ID.
- `PUT /medicos/{id}` → Modifica un médico.
- `DELETE /medicos/{id}` → Elimina un médico.

### Citas

- `GET /citas` → Lista todas las citas.
- `POST /citas` → Crea una nueva cita.
- `PUT /citas/{id}` → Modifica una cita.
- `DELETE /citas/{id}` → Cancela una cita.

## Documentación Swagger

La documentación de la API está disponible en Swagger. Para generar y acceder a la documentación:

1. Ejecutar:
   ```bash
   RAILS_ENV=test bundle exec rswag:specs:swaggerize
   ```
2. Acceder a:
   ```
   http://localhost:3001/api-docs
   ```

## Tecnologías Utilizadas

- **Ruby on Rails 7.1.5.1** (framework principal)
- **Oracle** (base de datos)
- **Doorkeeper** (autenticación de usuarios con OAuth2)
- **JWT** (manejo de tokens de autenticación)
- **RSpec** (pruebas automatizadas)
- **Rswag** (documentación API con Swagger)

## Licencia

Este proyecto está bajo la licencia MIT. Siéntete libre de contribuir y mejorar el código.

Repositorio Oficial: [hclp-be](https://github.com/hclazarte/hclp-be)
