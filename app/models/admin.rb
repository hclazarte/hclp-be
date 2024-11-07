class Admin < Profile
  # Método para gestionar inventario
  def manage_inventory(product, new_stock)
    product.update(stock: new_stock)
  end

  # Método para establecer descuentos en productos
  def set_promotion(product, discount)
    product.update(discount: discount)
  end
end
