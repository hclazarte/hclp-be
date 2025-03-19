class AddRedundantFieldsToMedicos < ActiveRecord::Migration[7.1]
  def change
    add_column :medicos, :nombre, :string
    add_column :medicos, :apellido_paterno, :string
    add_column :medicos, :apellido_materno, :string
    add_column :medicos, :cedula, :string
    add_column :medicos, :direccion, :string
    add_column :medicos, :movil, :string
    add_column :medicos, :email, :string
  end
end
