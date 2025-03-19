class CreateMedicos < ActiveRecord::Migration[7.1]
  def change
    create_table :medicos do |t|
      t.string :registro_profesional
      t.string :telefono
      t.string :telefono2
      t.integer :estado

      t.references :usuario, null: false, foreign_key: true

      t.timestamps
    end
  end
end
