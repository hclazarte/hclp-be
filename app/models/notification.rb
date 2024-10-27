class Notification < ApplicationRecord
  belongs_to :profile

  # Enumeración para los métodos de entrega
  enum delivery_method: { in_app: "in_app", email: "email", sms: "sms" }
  enum status: { pending: "pending", sent: "sent" }

  # Validaciones
  validates :message, :notification_type, :delivery_method, presence: true
end
