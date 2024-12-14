# app/models/digital_inventory_manager.rb
class DigitalInventoryManager < InventoryManager
  def add_product(product)
    # Lógica para añadir un producto digital al inventario
    puts "Adding digital product: #{product.name}"
  end

  def remove_product(product_id)
    # Lógica para eliminar un producto digital por ID
    puts "Removing digital product with ID: #{product_id}"
  end

  def update_stock(product_id, quantity)
    product = Product.find(product_id)
    raise InsufficientInventoryError if product.stock < quantity

    product.update!(stock: product.stock - quantity)
    puts "Inventario actualizado correctamente."
  rescue InsufficientInventoryError => e
    puts e.message
  end
end
