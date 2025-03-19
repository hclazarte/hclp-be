class Usuario < ApplicationRecord
  include QueryByExample

  has_secure_password

  enum rol: { admin: 0, medico: 1, paciente: 2 }

  validates :nombre, presence: true
  validates :apellido_paterno, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, if: :password_digest_changed?
end
