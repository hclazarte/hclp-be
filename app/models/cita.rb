class Cita < ApplicationRecord
  belongs_to :paciente
  belongs_to :medico

  self.table_name = "citas"

  enum estado: { pendiente: 0, confirmada: 1, cancelada: 2, atendida: 3 }

  validates :fecha, presence: true
  validates :hora, presence: true
  validates :estado, presence: true
end
