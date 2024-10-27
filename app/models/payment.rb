class Payment < ApplicationRecord
  belongs_to :order

  # Enumeración para definir los diferentes estados de la transacción
  enum status: { pending: "pending", paid: "paid", rejected: "rejected" }

  # Validaciones
  validates :method, presence: true
  validates :amount, numericality: { greater_than: 0 }
end
