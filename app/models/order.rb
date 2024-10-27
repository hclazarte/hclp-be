# app/models/order.rb
class Order < ApplicationRecord
  belongs_to :profile
  has_many :order_items, dependent: :destroy
  has_many :payments, dependent: :destroy
  has_one :shipment, dependent: :destroy
  accepts_nested_attributes_for :order_items

  validates :order_items, presence: true, length: { minimum: 1, message: 'debe incluir al menos un item en su orden' }

  after_create :adjust_product_stock
  before_save :calculate_total

  # Calcula el total del pedido sumando los subtotales con descuento aplicado
  def calculate_total
    self.total = order_items.sum do |item|
      (item.price * item.quantity) - (item.discount || 0)
    end
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
