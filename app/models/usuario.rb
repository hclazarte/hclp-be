class Usuario < ApplicationRecord
  has_secure_password

  enum rol: { admin: 0, medico: 1, paciente: 2 }

  validates :nombre, presence: true
  validates :email, presence: true, uniqueness: true
end
