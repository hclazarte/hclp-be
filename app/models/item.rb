class Item < ApplicationRecord
  self.abstract_class = true

  # Validaciones comunes
  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  # Método común para mostrar detalles (puede ser sobrescrito por subclases)
  def display_details
    "Name: #{name}, Price: #{price}"
  end
end
