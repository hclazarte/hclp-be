class Profile < ApplicationRecord
  # Relaciones
  has_many :orders, dependent: :destroy
  has_many :notifications, dependent: :destroy

  # Enumeraciones
  enum user_role: { customer: 0, admin: 1, manager: 2 }
  enum status: { pending: 0, verified: 1, suspended: 2 }

  # Autenticación
  has_secure_password

  # Validaciones
  validates :full_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }, if: -> { new_record? || password.present? }
  validates :password_confirmation, presence: true, if: -> { password.present? }
  
  # Valores por defecto
  attribute :two_factor_enabled, :boolean, default: false

  # Callbacks
  # Almacena el email en minúsculas para evitar duplicados
  before_save :downcase_email
  before_create :generate_verification_token

  # Asegúrate de que el atributo se inicialice en 0
  after_initialize do
    self.failed_otp_attempts ||= 0
    self.two_factor_enabled ||= false
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

  # Incrementar intentos fallidos y verificar si se excedió el límite
  def increment_failed_otp_attempts
    self.failed_otp_attempts += 1
    save!
  end

  # Restablecer intentos fallidos
  def reset_failed_otp_attempts
    self.failed_otp_attempts = 0
    save!
  end

  # Verificar si el usuario excedió el límite
  def exceeded_max_otp_attempts?
    self.failed_otp_attempts >= Rails.application.config.two_factor_max_attempts
  end

  # Genera un token único para la verificación
  def generate_verification_token
    self.verification_token = SecureRandom.hex(10)
    self.token_generated_at = Time.current
  end

  # Verifica si el token ha expirado (ejemplo: 24 horas)
  def token_expired?
    token_generated_at < 24.hours.ago
  end

  # Marca el email como verificado
  def mark_as_verified
    update(email_verified: true, status: 'verified', verification_token: nil, token_generated_at: nil)
  end

  def generate_reset_token
    self.reset_token = SecureRandom.hex(20)
    self.reset_token_sent_at = Time.current
    save!
  end

  # Verificar si el token ha expirado (válido por 2 horas)
  def reset_token_expired?
    reset_token_sent_at < 2.hours.ago
  end

  # Limpiar el token después de un restablecimiento exitoso
  def clear_reset_token
    self.reset_token = nil
    self.reset_token_sent_at = nil
    save!
  end

  private

  # Convierte el email a minúsculas antes de guardarlo
  def downcase_email
    self.email = email&.downcase
  end
end
