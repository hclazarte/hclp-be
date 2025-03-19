class HorarioMedico < ApplicationRecord
  belongs_to :medico
  attribute :estado, :integer
  after_initialize :set_default_duracion

  enum estado: { alta: 0, baja: 1 }

  private

  def set_default_duracion
    self.duracion_cita ||= 45
  end
end
