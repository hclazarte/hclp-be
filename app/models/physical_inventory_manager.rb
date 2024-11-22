# app/models/physical_inventory_manager.rb
class PhysicalInventoryManager < InventoryManager
  def add_product(product)
    # Lógica para añadir un producto físico al inventario
    puts "Adding physical product: #{product.name}"
  end

  def remove_product(product_id)
    # Lógica para eliminar un producto físico por ID
    puts "Removing physical product with ID: #{product_id}"
  end

  def update_stock(product_id, new_stock)
    # Lógica para actualizar el stock de un producto físico
    puts "Updating stock for physical product ID #{product_id} to #{new_stock}"
  end
end
