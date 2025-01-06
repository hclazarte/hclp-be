class Profile < ApplicationRecord
  # Relaciones
  has_many :orders, dependent: :destroy
  has_many :notifications, dependent: :destroy

  # Enumeraciones
  enum user_role: { customer: 0, admin: 1, manager: 2 }

  # Autenticación
  has_secure_password

  # Validaciones
  validates :full_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }, if: -> { new_record? || password.present? }
  validates :password_confirmation, presence: true, if: -> { password.present? }

  # Encapsulación de email
  def email
    read_attribute(:email)
  end

  def email=(value)
    raise ArgumentError, 'Formato de correo inválido' unless value.match?(URI::MailTo::EMAIL_REGEXP)

    write_attribute(:email, value)
  end

  def full_name
    read_attribute(:full_name)
  end

  def full_name=(value)
    raise ArgumentError, 'El nombre completo es obligatorio' if value.blank?

    write_attribute(:full_name, value)
  end

  # Generar un token de 6 dígitos y guardarlo en el modelo
  def generate_otp_token
    self.otp_token = format('%06d', rand(1..999999))
    self.otp_expires_at = 10.minutes.from_now
    save!
  end

  # Verificar que el token sea válido y no esté expirado
  def valid_otp_token?(token)
    self.otp_token == token && self.otp_expires_at > Time.current
  end

  # Limpiar el token después de usarlo
  def clear_otp_token
    self.otp_token = nil
    self.otp_expires_at = nil
    save!
  end
end
