class AddTwoFactorToProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :otp_token, :string
    add_column :profiles, :otp_expires_at, :datetime
  end
end
