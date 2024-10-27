class Profile < ApplicationRecord
  # Define roles de usuario con enumeración
  enum user_role: {
    customer: 0,
    admin: 1,
    manager: 2
  }

  has_secure_password
  has_many :orders, dependent: :destroy
  has_many :notifications, dependent: :destroy
  
  validates :password, presence: true, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
  validates :password_confirmation, presence: true, if: -> { password.present? }
  validates :full_name, :email, presence: true
  validates :email, uniqueness: true
end

