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

  def update_stock(product_id, new_stock)
    # Lógica para actualizar el stock de un producto digital
    puts "Updating stock for digital product ID #{product_id} to #{new_stock}"
  end
end
