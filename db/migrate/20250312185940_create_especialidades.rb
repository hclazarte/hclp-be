class CreateEspecialidades < ActiveRecord::Migration[7.1]
  def change
    create_table :especialidades do |t|
      t.string :nombre
      t.string :descripcion

      t.timestamps
    end
  end
end
