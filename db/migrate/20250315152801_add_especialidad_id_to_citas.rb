class AddEspecialidadIdToCitas < ActiveRecord::Migration[7.1]
  def change
    add_column :citas, :especialidad_id, :integer
    add_foreign_key :citas, :especialidades, column: :especialidad_id
  end
end
