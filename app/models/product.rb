class Product < ApplicationRecord
  has_many :related_products
  has_many :related_to_products, through: :related_products, source: :related_product
  has_many :product_images, dependent: :destroy

  # Validaciones
  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
