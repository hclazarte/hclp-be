class Profile < ApplicationRecord
  has_secure_password
  
  validates :password, presence: true, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
  validates :password_confirmation, presence: true, if: -> { password.present? }
end

