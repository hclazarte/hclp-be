# app/models/payment_process.rb
module PaymentProcess
  # Métodos que todas las clases de pago deben implementar
  def process_payment(amount, method)
    success = [true, false].sample # Simula éxito o fallo en el pago
    raise PaymentFailedError unless success

    puts "Pago de $#{amount} procesado exitosamente con #{method}."
  rescue PaymentFailedError => e
    puts e.message
  end

  def verify_payment(payment_id)
    raise NotImplementedError, "This method must be implemented in a class"
  end

  def confirm_payment(payment_id)
    raise NotImplementedError, "This method must be implemented in a class"
  end

end
