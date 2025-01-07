class ChangeStatusToIntegerInProfiles < ActiveRecord::Migration[7.0]
  def up
    # Cambiar status a integer y establecer 'pending' como 0 por defecto
    change_column :profiles, :status, :integer, using: 'status::integer', default: 0
  end

  def down
    # Revertir a VARCHAR2 y usar 'pending' como valor por defecto
    change_column :profiles, :status, :string, default: 'pending'
  end
end
