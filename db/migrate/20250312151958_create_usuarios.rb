class CreateUsuarios < ActiveRecord::Migration[7.1]
  def change
    create_table :usuarios do |t|
      t.string :nombre
      t.string :apellido_paterno
      t.string :apellido_materno
      t.string :cedula
      t.string :direccion
      t.string :movil
      t.string :email
      t.string :password_digest
      t.integer :rol

      t.timestamps
    end
  end
end
