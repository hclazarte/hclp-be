class Medico < ApplicationRecord
  include QueryByExample

  attribute :estado, :integer, default: 0

  belongs_to :usuario, optional: true

  enum estado: { alta: 0, baja: 1 }

  has_many :medico_especialidades, class_name: "MedicoEspecialidad", dependent: :destroy
  has_many :especialidades, through: :medico_especialidades, source: :especialidad
  has_many :horario_medicos, dependent: :destroy

  validates :nombre, presence: true
  validates :apellido_paterno, presence: true
  validates :cedula, presence: true, uniqueness: true
  validates :registro_profesional, presence: true
  validates :estado, presence: true
end
