
# Implementación de Encapsulamiento y Abstracción en Ruby on Rails

## Descripción del Proyecto

Este proyecto aplica los principios de **Encapsulamiento** y **Abstracción** en un sistema de e-commerce construido con Ruby on Rails. Los modelos existentes (`Product`, `Profile`, `Order`, `DigitalProduct`, y `PhysicalProduct`) han sido mejorados para garantizar una correcta protección de datos y una organización eficiente del código.

---

## Parte 1: Implementación de Encapsulamiento

### Cambios Realizados
1. **Encapsulamiento de Atributos Sensibles:**
   - Se encapsularon atributos como `price`, `stock`, `email`, y `status` para protegerlos y asegurar que solo sean accesibles y modificables a través de métodos públicos controlados.

2. **Validaciones en los Mutadores:**
   - Los mutadores (`attr=`) incluyen validaciones para evitar asignaciones inválidas, como precios negativos o formatos de correo electrónico no válidos.

3. **Acceso Restringido:**
   - Se utilizaron los métodos `read_attribute` y `write_attribute` para encapsular el acceso directo a los atributos en los modelos.

### Ejemplo Negativo
#### Código:
```ruby
# Intento de crear un producto digital con acceso directo a los atributos protegidos
digital_product = DigitalProduct.new

begin
  digital_product.price = -10 # Esto fallará porque el mutador no permite precios negativos
rescue ArgumentError => e
  puts "Error: #{e.message}" # Output: Error: Price must be a positive number
end
```

#### Resultado:
- El intento de asignar un valor negativo a `price` genera un error controlado: **"Price must be a positive number"**.
- Esto demuestra cómo el encapsulamiento protege los datos sensibles.

---

## Parte 2: Implementación de Abstracción

### Cambios Realizados
1. **Clase Base `Item`:**
   - Se introdujo una clase base abstracta `Item` que encapsula atributos y métodos comunes, como `name`, `price`, y `display_details`.

2. **Subclases Derivadas:**
   - `DigitalProduct` y `PhysicalProduct` heredan de `Product`, que a su vez hereda de `Item`. Esto asegura que las propiedades comunes se reutilicen, mientras las subclases implementan comportamientos específicos.

### Ejemplo de Abstracción
#### Código:
```ruby
# Creación de un producto digital
digital_product = DigitalProduct.new(name: "Ebook", price: 9.99, file_format: "PDF", file_size: 2)
puts digital_product.display_details
# Output: "Name: Ebook, Price: 9.99, File Format: PDF, File Size: 2MB"

# Creación de un producto físico
physical_product = PhysicalProduct.new(name: "Table", price: 79.99, weight: 15, dimensions: "120x60x75cm")
puts physical_product.display_details
# Output: "Name: Table, Price: 79.99, Weight: 15kg, Dimensions: 120x60x75cm"
```

#### Resultado:
- Los productos digitales y físicos comparten atributos comunes (`name`, `price`), mientras mantienen sus propias validaciones y métodos específicos.

---

## Beneficios de la Implementación

1. **Protección de Datos:**
   - El encapsulamiento asegura que los datos sensibles no se puedan modificar directamente sin pasar por validaciones.

2. **Reutilización de Código:**
   - La abstracción organiza las propiedades comunes en clases base, reduciendo duplicación y mejorando la mantenibilidad.

3. **Extensibilidad:**
   - Es fácil agregar nuevos tipos de productos o elementos, como `SubscriptionProduct`, sin alterar la estructura existente.

4. **Validaciones Consistentes:**
   - Cada clase valida sus atributos específicos, asegurando que los datos sean siempre correctos y válidos.

---

## Instrucciones para Ejecutar

1. **Configuración Inicial:**
   - Clonar el repositorio y configurar las dependencias con `bundle install`.

2. **Migraciones:**
   - Ejecutar `rails db:migrate` para aplicar las definiciones de las tablas.

3. **Consola de Rails:**
   - Usar `rails console` para probar las clases y métodos implementados.

4. **Pruebas:**
   - Ejecutar los ejemplos proporcionados para verificar el comportamiento esperado.

---

## Archivos Modificados
1. `app/models/item.rb` (Nueva clase base abstracta).
2. `app/models/product.rb` (Clase intermedia).
3. `app/models/digital_product.rb` (Subclase específica).
4. `app/models/physical_product.rb` (Subclase específica).
5. `app/models/profile.rb` (Encapsulamiento de `email`).
6. `app/models/order.rb` (Encapsulamiento de `status` y `total`).

---

## Créditos

Este README y las modificaciones al código fueron realizados como parte de una tarea académica para demostrar conceptos de encapsulamiento y abstracción en Ruby on Rails.
