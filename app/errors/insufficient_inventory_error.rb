# Excepción para inventario insuficiente
class InsufficientInventoryError < StandardError
  def initialize(message = /No hay suficiente inventario para completar la operación./)
    super
  end
end