# app/models/order.rb
class Order < ApplicationRecord
  belongs_to :profile
  has_many :order_items, dependent: :destroy

  accepts_nested_attributes_for :order_items

  # Calcula el total de la orden automáticamente
  def calculate_total
    self.total = order_items.sum { |item| item.quantity * item.price }
    save
  end
end
