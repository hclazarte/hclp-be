# app/models/order_item.rb
class OrderItem < ApplicationRecord
  # Asociaciones
  belongs_to :order
  belongs_to :product

  # Validaciones
  validates :quantity, numericality: { greater_than: 0 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  # Métodos para calcular el subtotal de cada item
  def subtotal
    quantity * price
  end
end
