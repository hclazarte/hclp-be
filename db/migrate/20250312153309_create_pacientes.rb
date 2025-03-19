class CreatePacientes < ActiveRecord::Migration[7.1]
  def change
    create_table :pacientes do |t|
      t.integer :estado_civil
      t.string :ocupacion
      t.date :fecha_nacimiento
      t.string :lugar_nacimiento
      t.string :telefono
      t.integer :tipo_afiliado
      t.integer :tipo_sangre
      t.integer :estado

      t.references :usuario, null: false, foreign_key: true

      t.timestamps
    end
  end
end
