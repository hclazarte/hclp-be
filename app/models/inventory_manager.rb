# app/models/inventory_manager.rb
class InventoryManager
  # Métodos abstractos para la gestión de inventario
  def add_product(product)
    raise NotImplementedError, "This method must be implemented in a subclass"
  end

  def remove_product(product_id)
    raise NotImplementedError, "This method must be implemented in a subclass"
  end

  def update_stock(product_id, quantity)
    product = Product.find(product_id)
    raise InsufficientInventoryError if product.stock < quantity

    product.update!(stock: product.stock - quantity)
    puts "Inventario actualizado correctamente."
  end
end
