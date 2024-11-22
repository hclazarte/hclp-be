# app/models/card_payment.rb
class CardPayment
  include PaymentProcess

  def start_payment(amount)
    # Lógica para iniciar un pago con tarjeta
    puts "Starting card payment for $#{amount}"
  end

  def verify_payment(payment_id)
    # Lógica para verificar un pago con tarjeta
    puts "Verifying card payment with ID: #{payment_id}"
  end

  def confirm_payment(payment_id)
    # Lógica para confirmar un pago con tarjeta
    puts "Confirming card payment with ID: #{payment_id}"
  end
end
