
# Implementación de Interfaces y Clases Abstractas

## Descripción del Proyecto

Este proyecto aplica los principios de **abstracción** e **interfaces** en un sistema para la gestión de inventario y procesos de pago. Se implementan clases abstractas para estandarizar la gestión de inventario y se utilizan interfaces para definir contratos para los procesos de pago.

---

## Implementación

### Clases Abstractas: Gestión de Inventario

1. **Clase Abstracta `InventoryManager`:**
   - Define métodos abstractos como `add_product`, `remove_product`, y `update_stock`.
   - Las clases concretas (`DigitalInventoryManager` y `PhysicalInventoryManager`) implementan estos métodos según las necesidades de diferentes tipos de inventarios.

2. **Ejemplo de Uso:**
```ruby
# Crear una instancia del gestor de inventario digital
digital_inventory = DigitalInventoryManager.new
digital_inventory.add_product(Product.new(name: "E-book"))
```

### Interfaces: Procesos de Pago

1. **Interfaz `PaymentProcess`:**
   - Define métodos como `start_payment`, `verify_payment`, y `confirm_payment`.
   - Implementaciones concretas incluyen `CardPayment` y `PayPalPayment`.

2. **Ejemplo de Uso:**
```ruby
# Crear una instancia de pago con tarjeta
card_payment = CardPayment.new
card_payment.start_payment(100.00)
```

---

## Tecnologías Utilizadas

- Ruby 3.1
- Ruby on Rails 7.x

---

## Instrucciones para Ejecutar

1. **Configuración Inicial:**
   - Clonar el repositorio y ejecutar `bundle install`.

2. **Pruebas en Consola:**
   - Usar `rails console` para crear instancias de las clases implementadas y probar los métodos.

3. **Ejemplo en Consola:**
```ruby
# Crear y gestionar un inventario digital
digital_inventory = DigitalInventoryManager.new
digital_inventory.add_product(Product.new(name: "Digital Book"))

# Procesar un pago con PayPal
paypal_payment = PayPalPayment.new
paypal_payment.start_payment(50.00)
```

---

## Desafíos y Soluciones

### Desafío: Definir métodos abstractos en Ruby
**Solución:** Usar `raise NotImplementedError` en métodos de la clase abstracta.

### Desafío: Establecer contratos con interfaces
**Solución:** Usar módulos para definir interfaces y garantizar que las clases implementen los métodos requeridos.
