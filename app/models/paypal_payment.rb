# app/models/paypal_payment.rb
class PaypalPayment
  include PaymentProcess

  def start_payment(amount)
    # Lógica para iniciar un pago con PayPal
    puts "Starting PayPal payment for $#{amount}"
  end

  def verify_payment(payment_id)
    # Lógica para verificar un pago con PayPal
    puts "Verifying PayPal payment with ID: #{payment_id}"
  end

  def confirm_payment(payment_id)
    # Lógica para confirmar un pago con PayPal
    puts "Confirming PayPal payment with ID: #{payment_id}"
  end
end
