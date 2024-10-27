class Shipment < ApplicationRecord
  belongs_to :order

  # Enumeración para definir los diferentes estados de envío
  enum status: { in_preparation: "in_preparation", shipped: "shipped", in_transit: "in_transit", delivered: "delivered" }

  # Validaciones
  validates :address, :city, :state, :postal_code, :method, :cost, presence: true
  validates :cost, numericality: { greater_than_or_equal_to: 0 }
end
