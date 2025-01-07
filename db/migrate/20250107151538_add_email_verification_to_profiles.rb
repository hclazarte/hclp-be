class AddEmailVerificationToProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :status, :string, default: "pending" # Estado del perfil
    add_column :profiles, :email_verified, :boolean, default: false # Indicador de verificación
    add_column :profiles, :verification_token, :string # Token único para verificación
    add_column :profiles, :token_generated_at, :datetime # Timestamp de generación del token

    add_index :profiles, :email, unique: true # Índice único para garantizar unicidad del email
    add_index :profiles, :verification_token, unique: true # Índice único para el token de verificación
  end
end
