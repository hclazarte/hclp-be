# Asignación No. 4: Aplicación de Polimorfismo y Sobrecarga en una Plataforma e-Commerce

## Descripción General

En esta asignación, implementamos **polimorfismo**, **sobrecarga de métodos** y **sobreescritura de métodos** en nuestra plataforma e-Commerce para manejar diferentes tipos de productos (`DigitalProduct` y `PhysicalProduct`) y ofrecer flexibilidad en el manejo de operaciones de productos y carritos de compra.

### Requerimientos:

1. **Polimorfismo**:
   - Permitir que objetos de diferentes clases derivadas sean tratados como objetos de su clase base (`Product`), implementando un método que funcione con `DigitalProduct` y `PhysicalProduct`.
  
2. **Sobrecarga de Métodos**:
   - Implementar la sobrecarga de métodos en clases relevantes, como en `Cart`, para permitir agregar productos al carrito mediante diferentes tipos de argumentos.
  
3. **Sobreescritura de Métodos**:
   - Demostrar la sobreescritura de métodos en clases derivadas (`DigitalProduct` y `PhysicalProduct`) para mostrar detalles específicos de cada tipo de producto.

## Implementación de Polimorfismo

### Método `apply_discount` en `Product`

Implementamos un método `apply_discount` en la clase base `Product` para aplicar un descuento a cualquier producto, ya sea `DigitalProduct` o `PhysicalProduct`. Gracias al polimorfismo, podemos aplicar el mismo método a ambas subclases, tratándolas como `Product`.

#### Ejemplo de Uso

```ruby
products = [DigitalProduct.new(name: "Ebook", price: 10), PhysicalProduct.new(name: "Laptop", price: 1000)]

products.each do |product|
  product.apply_discount(10) # Aplica un 10% de descuento a cada producto
  puts "#{product.name}: #{product.price}"
end
