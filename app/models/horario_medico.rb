class HorarioMedico < ApplicationRecord
  belongs_to :medico

  enum estado: { alta: 0, baja: 1}
end
