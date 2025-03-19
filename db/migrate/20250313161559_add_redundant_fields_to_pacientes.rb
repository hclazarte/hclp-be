class AddRedundantFieldsToPacientes < ActiveRecord::Migration[7.1]
  def change
    add_column :pacientes, :nombre, :string
    add_column :pacientes, :apellido_paterno, :string
    add_column :pacientes, :apellido_materno, :string
    add_column :pacientes, :cedula, :string
    add_column :pacientes, :direccion, :string
    add_column :pacientes, :movil, :string
    add_column :pacientes, :email, :string
  end
end
