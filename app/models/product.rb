class Product < ApplicationRecord
  # Relaciones
  has_many :related_products
  has_many :related_to_products, through: :related_products, source: :related_product
  has_many :product_images, dependent: :destroy

  # Validaciones
  validates :stock, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # Métodos públicos para encapsulamiento
  def price
    read_attribute(:price)
  end

  def price=(value)
    raise ArgumentError, 'EL precio debe ser positivo' if value.to_f.negative?

    write_attribute(:price, value)
  end

  def stock
    read_attribute(:stock)
  end

  def stock=(value)
    raise ArgumentError, 'El stock no puede ser negativo' if value.to_i.negative?

    write_attribute(:stock, value)
  end

 # Comportamientos comunes para productos
 def in_stock?
  stock > 0
  end

  def apply_discount(percentage)
    self.price -= (self.price * (percentage / 100.0))
  end
end
