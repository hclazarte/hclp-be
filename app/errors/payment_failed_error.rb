# Excepción para pagos fallidos
class PaymentFailedError < StandardError
  def initialize(message = "El proceso de pago ha fallado. Por favor, intente nuevamente.")
    super
  end
end