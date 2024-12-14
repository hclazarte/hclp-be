
# Implementación de Manejo de Excepciones y Pruebas Unitarias en e-Commerce

Este proyecto aplica manejo de excepciones personalizado y pruebas unitarias utilizando **RSpec** en un sistema e-Commerce. Incluye clases y módulos para la gestión de inventario, pagos y productos, asegurando que las operaciones críticas sean robustas y estén bien probadas.

---

## Manejo de Excepciones

Se implementaron excepciones personalizadas para reflejar errores específicos:

### 1. Excepción `InsufficientInventoryError`

Lanzada cuando el inventario es insuficiente para completar una operación.

```ruby
# Ejemplo en Active Record
product = Product.create(name: "Libro", stock: 10, price: 20.0)
begin
  raise InsufficientInventoryError if product.stock < 15
rescue InsufficientInventoryError => e
  puts e.message # Output: "No hay suficiente inventario para completar la operación."
end
```

---

### 2. Excepción `PaymentFailedError`

Lanzada cuando un proceso de pago falla.

```ruby
payment_processor = CardPayment.new
begin
  payment_processor.process_payment(100, "tarjeta")
rescue PaymentFailedError => e
  puts e.message # Output: "El proceso de pago ha fallado. Por favor, intente nuevamente."
end
```

---

### 3. Excepción `UnauthorizedUserError`

Lanzada cuando un usuario intenta realizar una acción no autorizada.

```ruby
begin
  raise UnauthorizedUserError
rescue UnauthorizedUserError => e
  puts e.message # Output: "No tienes permiso para realizar esta acción."
end
```

---

## Pruebas Unitarias con RSpec

Se escribieron pruebas unitarias para las clases de inventario, pagos y productos.

### 1. Pruebas para Gestión de Inventario

Archivo: `spec/models/inventory_manager_spec.rb`

```ruby
RSpec.describe InventoryManager, type: :model do
  let(:product) { Product.create(name: "Inventory Test", stock: 10, price: 20.0) }
  let(:inventory_manager) { InventoryManager.new }

  it "actualiza correctamente el inventario cuando hay stock suficiente" do
    expect { inventory_manager.update_stock(product.id, 5) }
      .to change { product.reload.stock }.by(-5)
  end

  it "lanza una excepción cuando el inventario es insuficiente" do
    expect { inventory_manager.update_stock(product.id, 15) }
      .to raise_error(InsufficientInventoryError, /No hay suficiente inventario para completar la operación./)
  end
end
```

---

### 2. Pruebas para Procesos de Pago

Archivo: `spec/models/payment_processor_spec.rb`

```ruby
RSpec.describe CardPayment, type: :model do
  let(:payment_processor) { CardPayment.new }

  it "procesa un pago exitoso" do
    allow(payment_processor).to receive(:process_payment).and_return("Pago exitoso.")
    expect(payment_processor.process_payment(100, "tarjeta")).to eq("Pago exitoso.")
  end

  it "lanza una excepción cuando el pago falla" do
    allow(payment_processor).to receive(:process_payment).and_raise(PaymentFailedError)
    expect { payment_processor.process_payment(100, "tarjeta") }
      .to raise_error(PaymentFailedError, /El proceso de pago ha fallado/)
  end
end
```

---

### 3. Pruebas para el Modelo de Producto

Archivo: `spec/models/product_spec.rb`

```ruby
RSpec.describe Product, type: :model do
  let(:product) { Product.new(name: "Products Test", stock: 10, price: 20.0) }

  it "es válido con todos los atributos requeridos" do
    expect(product).to be_valid
  end

  it "no es válido sin un nombre" do
    product.name = nil
    expect(product).not_to be_valid
  end

  it "no permite precios negativos" do
    product.price = -10
    expect(product).not_to be_valid
  end

  it "no permite stock negativo" do
    product.stock = -5
    expect(product).not_to be_valid
  end
end
```

---

## Ejemplo en Consola con Active Record

### Creación de Productos

```ruby
product = Product.create(name: "Laptop", stock: 5, price: 1500.0)
puts product.name # Output: "Laptop"
puts product.in_stock? # Output: true
```

### Actualización de Stock

```ruby
inventory_manager = InventoryManager.new
inventory_manager.update_stock(product.id, 3)
puts product.reload.stock # Output: 2
```

### Proceso de Pago

```ruby
payment_processor = CardPayment.new
payment_processor.process_payment(500, "tarjeta")
```

---

## Desafíos y Soluciones

1. **Manejo de Excepciones Personalizadas:**
   - Se aseguraron mensajes claros en español para brindar retroalimentación adecuada.

2. **Validaciones de Atributos:**
   - Se implementaron validaciones estándar de Active Record para evitar datos inválidos como precios negativos o stock negativo.

3. **Pruebas Robustas:**
   - RSpec se configuró para cubrir casos exitosos y de error, asegurando que el sistema se comporte correctamente en todos los escenarios.

---

## Instrucciones para Ejecutar

1. **Instalar Dependencias:**
   ```bash
   bundle install
   ```

2. **Preparar la Base de Datos:**
   ```bash
   rails db:create
   rails db:migrate
   ```

3. **Ejecutar Pruebas:**
   ```bash
   rspec
   ```

4. **Ver Resultados:**
   - Los resultados exitosos aparecerán con un indicador verde.
   - Los errores o fallos serán mostrados en rojo.
