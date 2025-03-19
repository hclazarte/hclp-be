class MedicoEspecialidad < ApplicationRecord
  belongs_to :medico
  belongs_to :especialidad

  self.table_name = "medico_especialidades"
end
