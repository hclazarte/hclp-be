# Backend del Sistema de Gestión de Citas Médicas

Este es el backend del **Sistema de Gestión de Citas Médicas**, desarrollado en **Ruby on Rails** con **Oracle** como base de datos.

## Requisitos Previos

Asegúrate de tener instalados los siguientes paquetes antes de iniciar el proyecto:

- **Ruby** (versión recomendada: 3.2.3)
- **Rails** (versión recomendada: 7.1.5.1)
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

- `POST /api/login` → Inicia sesión y obtiene un token.

### Usuarios

- `PATCH /usuarios/filtrar` → Filtra usuarios con 
- `POST /usuarios` → Crea un nuevo usuarios.parámetros avanzados.
- `GET /usuarios/{id}` → Obtiene un usuario por ID.
- `PUT /usuarios/{id}` → Modifica un usuario.
- `DELETE /usuarios/{id}` → Elimina un usuario.

### Pacientes

- `PATCH /pacientes/filtrar` → Filtra pacientes con parámetros avanzados.
- `POST /pacientes` → Crea un nuevo paciente.
- `GET /pacientes/{id}` → Obtiene un paciente por ID.
- `PUT /pacientes/{id}` → Modifica un paciente.
- `DELETE /pacientes/{id}` → Elimina un paciente.

### Médicos
- `PATCH /medicos/filtrar` → Filtra medicos con parámetros avanzados.
- `POST /medicos` → Registra un nuevo médico.
- `GET /medicos/{id}` → Obtiene un médico por ID.
- `PUT /medicos/{id}` → Modifica un médico.
- `DELETE /medicos/{id}` → Elimina un médico.

### Citas
- `PATCH /citas/disponibles` → Consulta citas disponibles.
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
   O a la versión publicada:
   ```
   https://hclp.online/api-docs/index.html
   ```

## Tecnologías Utilizadas

- **Ruby on Rails 7.1.5.1** (framework principal)
- **Oracle** (base de datos)
- **Doorkeeper** (autenticación de usuarios con OAuth2)
- **RSpec** (pruebas automatizadas)
- **Rswag** (documentación API con Swagger)

Repositorio Oficial: [hclp-be](https://github.com/hclazarte/hclp-be)
