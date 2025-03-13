class ChangeUsuarioIdNullable < ActiveRecord::Migration[7.1]
  def change
    change_column_null :pacientes, :usuario_id, true
    change_column_null :medicos, :usuario_id, true
  end
end
