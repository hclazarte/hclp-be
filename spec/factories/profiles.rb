FactoryBot.define do
  factory :profile do
    full_name { "Test User" }
    email { "user@example.com" }
    password { "password123" }
    password_confirmation { "password123" }
    password_digest { BCrypt::Password.create(password) }
    two_factor_enabled { true }
    failed_otp_attempts { 0 }
    otp_token { nil }
    otp_expires_at { nil }
  end
end
