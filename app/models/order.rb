class Order < ApplicationRecord
  # Relaciones
  belongs_to :profile
  has_many :order_items, dependent: :destroy
  has_many :payments, dependent: :destroy
  has_one :shipment, dependent: :destroy

  accepts_nested_attributes_for :order_items

  # Validaciones
  validates :order_items, presence: true, length: { minimum: 1, message: 'debe incluir al menos un item en su orden' }
  validates :status, presence: true, inclusion: { in: %w[pending completed cancelled] }
  validates :total, numericality: { greater_than_or_equal_to: 0 }

  # Callbacks
  after_create :adjust_product_stock
  before_save :calculate_total

  # Encapsulación de atributos
  def status
    read_attribute(:status)
  end

  def status=(value)
    allowed_statuses = %w[pending completed cancelled]
    raise ArgumentError, "Status inválido: #{value}" unless allowed_statuses.include?(value)

    write_attribute(:status, value)
  end

  def total
    read_attribute(:total)
  end

  def total=(value)
    raise ArgumentError, 'El total debe ser positivo' if value.to_f.negative?

    write_attribute(:total, value)
  end

  # Métodos privados
  private

  def adjust_product_stock
    order_items.each do |item|
      product = item.product
      product.stock -= item.quantity
      product.save!
    end
  end

  def calculate_total
    self.total = order_items.sum do |item|
      (item.price * item.quantity) - (item.discount || 0)
    end
  end
end
