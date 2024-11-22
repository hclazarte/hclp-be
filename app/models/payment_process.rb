# app/models/payment_process.rb
module PaymentProcess
  # Métodos que todas las clases de pago deben implementar
  def start_payment(amount)
    raise NotImplementedError, "This method must be implemented in a class"
  end

  def verify_payment(payment_id)
    raise NotImplementedError, "This method must be implemented in a class"
  end

  def confirm_payment(payment_id)
    raise NotImplementedError, "This method must be implemented in a class"
  end
end
