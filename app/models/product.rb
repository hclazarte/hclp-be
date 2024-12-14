class Product < ApplicationRecord
  # Relaciones
  has_many :related_products
  has_many :related_to_products, through: :related_products, source: :related_product
  has_many :product_images, dependent: :destroy

  # Validaciones
  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # Métodos públicos para encapsulamiento
  def price
    read_attribute(:price)
  end

  def price=(value)
    write_attribute(:price, value.to_f) # Asegura que el valor sea float
  end

  def stock
    read_attribute(:stock)
  end

  def stock=(value)
    write_attribute(:stock, value.to_i) # Asegura que el valor sea un entero
  end

  # Comportamientos comunes para productos
  def in_stock?
    stock > 0
  end

  def apply_discount(percentage)
    self.price -= (self.price * (percentage / 100.0))
  end
end
