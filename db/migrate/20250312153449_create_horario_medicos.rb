class CreateHorarioMedicos < ActiveRecord::Migration[7.1]
  def change
    create_table :horario_medicos do |t|
      t.references :medico, null: false, foreign_key: true
      t.string :dia
      t.time :hora_inicio
      t.time :hora_fin

      t.timestamps
    end
  end
end
