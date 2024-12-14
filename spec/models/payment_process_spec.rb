require 'rails_helper'

RSpec.describe CardPayment, type: :model do
  let(:payment_processor) { CardPayment.new }

  it "procesa un pago exitoso" do
    allow(payment_processor).to receive(:process_payment).and_return("Pago exitoso.")
    expect(payment_processor.process_payment(100, "tarjeta")).to eq("Pago exitoso.")
  end

  it "lanza una excepción cuando el pago falla" do
    allow(payment_processor).to receive(:process_payment).and_raise(PaymentFailedError)
    expect { payment_processor.process_payment(100, "tarjeta") }
      .to raise_error(PaymentFailedError, /El proceso de pago ha fallado/)
  end
end
