# app/models/inventory_manager.rb
class InventoryManager
  # Métodos abstractos para la gestión de inventario
  def add_product(product)
    raise NotImplementedError, "This method must be implemented in a subclass"
  end

  def remove_product(product_id)
    raise NotImplementedError, "This method must be implemented in a subclass"
  end

  def update_stock(product_id, new_stock)
    raise NotImplementedError, "This method must be implemented in a subclass"
  end
end
