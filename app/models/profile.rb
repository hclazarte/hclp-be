class Profile < ApplicationRecord
  has_secure_password

    # # Método de clase para autenticar al usuario
    # def self.authenticate(email, password)
    #   profile = find_by(email: email)
    #   profile && profile.authenticate(password) ? profile : nil
    # end
end
