class AddResetTokenToProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :reset_token, :string
    add_column :profiles, :reset_token_sent_at, :datetime
  end
end
