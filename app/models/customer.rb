class Customer < Profile
  # Método para obtener el historial de compras
  def purchase_history
    orders.where(status: 'completed')
  end

  # Método para establecer preferencias del cliente
  def update_preferences(email: true, sms: false, in_app: true)
    update(prefers_email: email, prefers_sms: sms, prefers_in_app: in_app)
  end
end
