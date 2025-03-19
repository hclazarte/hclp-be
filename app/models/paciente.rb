class Paciente < ApplicationRecord
  include QueryByExample

  attribute :estado, :integer, default: 0

  belongs_to :usuario, optional: true

  enum estado_civil: { soltero: 0, casado: 1, divorciado: 2, viudo: 3 }
  enum tipo_afiliado: { titular: 0, beneficiario: 1 }
  enum tipo_sangre: { orh_n: 0, orh_p: 1, arh_n: 2, arh_p: 3, brh_n: 4, brh_p: 5, abrh_n: 6, abrh_p: 7 }
  enum estado: { alta: 0, baja: 1 }

  validates :nombre, presence: true
  validates :apellido_paterno, presence: true
  validates :cedula, presence: true, uniqueness: true
  validates :fecha_nacimiento, presence: true
  validates :tipo_sangre, presence: true
  validates :estado, presence: true
end
