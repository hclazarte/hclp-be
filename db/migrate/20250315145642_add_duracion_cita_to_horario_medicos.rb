class AddDuracionCitaToHorarioMedicos < ActiveRecord::Migration[7.1]
  def change
    add_column :horario_medicos, :duracion_cita, :integer
  end
end
