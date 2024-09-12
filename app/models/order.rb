# app/models/order.rb
class Order < ApplicationRecord
  belongs_to :profile
  has_many :order_items, dependent: :destroy
  accepts_nested_attributes_for :order_items

  validates :order_items, presence: true, length: { minimum: 1, message: 'debe incluir al menos un item en su orden' }

  after_create :adjust_product_stock

  # Calcula el total de la orden automáticamente
  def calculate_total
    self.total = order_items.sum { |item| item.quantity * item.price }
    save
  end

  private

  # Método para ajustar el stock de los productos asociados a la orden
  def adjust_product_stock
    order_items.each do |item|
      product = item.product
      product.stock -= item.quantity
      product.save
    end
  end
end
