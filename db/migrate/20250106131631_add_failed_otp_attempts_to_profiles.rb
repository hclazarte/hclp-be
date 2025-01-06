class AddFailedOtpAttemptsToProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :failed_otp_attempts, :integer
  end
end
