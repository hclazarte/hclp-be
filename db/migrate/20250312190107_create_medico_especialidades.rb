class CreateMedicoEspecialidades < ActiveRecord::Migration[7.1]
  def change
    create_table :medico_especialidades do |t|
      t.references :medico, null: false, foreign_key: true
      t.references :especialidad, null: false, foreign_key: { to_table: :especialidades }

      t.timestamps
    end
  end
end
