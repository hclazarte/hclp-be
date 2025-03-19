class Especialidad < ApplicationRecord
  self.table_name = "especialidades"
  has_many :medico_especialidades, class_name: "MedicoEspecialidad"
  has_many :medicos, through: :medico_especialidades
end
