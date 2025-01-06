class SetDefaultForFailedOtpAttempts < ActiveRecord::Migration[7.0]
  def change
    change_column_default :profiles, :failed_otp_attempts, from: nil, to: 0
    change_column_null :profiles, :failed_otp_attempts, false
  end
end
