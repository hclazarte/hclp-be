class AddTwoFactorEnabledToProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :two_factor_enabled, :boolean
  end
end
