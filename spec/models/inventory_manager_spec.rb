require 'rails_helper'

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
