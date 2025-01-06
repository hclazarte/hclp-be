require 'rails_helper'

RSpec.describe Profile, type: :model do
  let(:profile) { create(:profile) }

  describe "#generate_otp_token" do
    it "genera un token de 6 dígitos" do
      profile.generate_otp_token
      expect(profile.otp_token).to match(/\A\d{6}\z/)
    end

    it "establece una fecha de expiración para el token" do
      profile.generate_otp_token
      expect(profile.otp_expires_at).to be_within(1.second).of(10.minutes.from_now)
    end
  end

  describe "#valid_otp_token?" do
    it "devuelve true si el token es válido y no ha expirado" do
      profile.generate_otp_token
      expect(profile.valid_otp_token?(profile.otp_token)).to be true
    end

    it "devuelve false si el token ha expirado" do
      profile.generate_otp_token
      profile.update!(otp_expires_at: 5.minutes.ago)
      expect(profile.valid_otp_token?(profile.otp_token)).to be false
    end

    it "devuelve false si el token es incorrecto" do
      profile.generate_otp_token
      expect(profile.valid_otp_token?("wrong_token")).to be false
    end
  end

  describe "#increment_failed_otp_attempts" do
    it "incrementa el contador de intentos fallidos" do
      expect { profile.increment_failed_otp_attempts }.to change { profile.failed_otp_attempts }.by(1)
    end
  end

  describe "#reset_failed_otp_attempts" do
    it "resetea el contador de intentos fallidos a 0" do
      profile.increment_failed_otp_attempts
      profile.reset_failed_otp_attempts
      expect(profile.failed_otp_attempts).to eq(0)
    end
  end

  describe "#exceeded_max_otp_attempts?" do
    it "devuelve true si los intentos fallidos superan el límite" do
      Rails.application.config.two_factor_max_attempts = 3
      profile.update!(failed_otp_attempts: 3)
      expect(profile.exceeded_max_otp_attempts?).to be true
    end

    it "devuelve false si los intentos fallidos no superan el límite" do
      Rails.application.config.two_factor_max_attempts = 3
      profile.update!(failed_otp_attempts: 2)
      expect(profile.exceeded_max_otp_attempts?).to be false
    end
  end
end
