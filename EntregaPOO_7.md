
# Implementación de Patrones de Diseño: Singleton, Factory y Observer

## Descripción del Proyecto

Este proyecto aplica los patrones de diseño **Singleton**, **Factory** y **Observer** en un sistema e-Commerce. Cada patrón se implementa para resolver problemas específicos de gestión de configuración, creación de objetos y manejo de eventos en el sistema.

---

## Implementación

### 1. Patrón Singleton: Gestión de Configuración

Se utiliza el patrón Singleton para garantizar que solo exista una instancia de la clase `AppConfig`, que maneja las configuraciones centrales del sistema.

#### Código
```ruby
class AppConfig
  @instance = nil

  private_class_method :new

  def self.instance
    @instance ||= new
  end

  def initialize
    @settings = {
      database: "ecommerce_db",
      ui_theme: "light",
      cache_enabled: true
    }
  end

  def get(key)
    @settings[key]
  end

  def set(key, value)
    @settings[key] = value
  end
end
```

#### Ejemplo en Consola
```ruby
config = AppConfig.instance
config.set(:ui_theme, "dark")
puts config.get(:ui_theme)
```

#### Salida en Consola
```
dark
```

---

### 2. Patrón Factory: Creación de Objetos

El patrón Factory simplifica la creación de objetos `Product` y `User`, basándose en parámetros específicos.

#### Código
```ruby
class EntityFactory
  def self.create_entity(type, attributes = {})
    case type.to_sym
    when :digital_product
      DigitalProduct.new(attributes)
    when :physical_product
      PhysicalProduct.new(attributes)
    when :customer
      Profile.new(attributes.merge(user_role: "customer"))
    when :admin
      Profile.new(attributes.merge(user_role: "admin"))
    else
      raise "Unknown entity type: #{type}"
    end
  end
end
```

#### Ejemplo en Consola
```ruby
digital_product = EntityFactory.create_entity(:digital_product, name: "E-book", price: 10.0)
puts digital_product.inspect

admin = EntityFactory.create_entity(:admin, full_name: "Admin User", email: "admin@example.com", password: "secure123")
puts admin.inspect
```

#### Salida en Consola
```
#<DigitalProduct name: "E-book", price: 10.0>
#<Profile full_name: "Admin User", email: "admin@example.com", user_role: "admin">
```

---

### 3. Patrón Observer: Manejo de Eventos

Se implementa un sistema de notificaciones basado en el patrón Observer. Permite que diferentes partes del sistema se suscriban a eventos y reciban notificaciones.

#### Código
```ruby
class NotificationCenter
  def initialize
    @observers = {}
  end

  def subscribe(event_name, observer)
    @observers[event_name] ||= []
    @observers[event_name] << observer
  end

  def notify(event_name, data = nil)
    return unless @observers[event_name]

    @observers[event_name].each do |observer|
      observer.update(event_name, data)
    end
  end
end

class InventoryObserver
  def update(event_name, data)
    puts "Inventory updated for event: #{event_name}, data: #{data}"
  end
end

class OrderObserver
  def update(event_name, data)
    puts "Order status changed for event: #{event_name}, data: #{data}"
  end
end
```

#### Ejemplo en Consola
```ruby
notification_center = NotificationCenter.new

inventory_observer = InventoryObserver.new
order_observer = OrderObserver.new

notification_center.subscribe(:order_status_changed, order_observer)
notification_center.subscribe(:inventory_updated, inventory_observer)

notification_center.notify(:order_status_changed, { order_id: 123, status: "shipped" })
notification_center.notify(:inventory_updated, { product_id: 456, stock: 20 })
```

#### Salida en Consola
```
Order status changed for event: order_status_changed, data: {:order_id=>123, :status=>"shipped"}
Inventory updated for event: inventory_updated, data: {:product_id=>456, :stock=>20}
```

---

## Tecnologías Utilizadas

- **Ruby 3.2**
- **Ruby on Rails 7.x**

---

## Instrucciones para Ejecutar

1. **Configuración Inicial:**
   - Clonar el repositorio y ejecutar `bundle install`.

2. **Pruebas en Consola:**
   - Usar `rails console` para probar los ejemplos proporcionados.

3. **Ejemplo:**
   ```ruby
   config = AppConfig.instance
   config.set(:ui_theme, "dark")
   puts config.get(:ui_theme)
   ```

---

## Desafíos y Soluciones

1. **Evitar múltiples instancias en Singleton:**
   - Se utilizó `private_class_method :new` para garantizar que `new` no sea accesible desde fuera de la clase.

2. **Definir contratos con Factory:**
   - Se implementó un manejo de errores claro para tipos desconocidos.

3. **Notificaciones con Observer:**
   - Se diseñó un sistema extensible para añadir nuevos eventos y observadores fácilmente.

---

## Licencia

Este proyecto se distribuye bajo la licencia MIT.
