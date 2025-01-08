require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'Validaciones' do
    it { should validate_presence_of(:full_name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:password).on(:create) }
    it { should validate_length_of(:password).is_at_least(6) }
    it 'valida el formato del correo' do
      should allow_value('user@example.com').for(:email)
      should_not allow_value('invalid_email').for(:email)
    end
    it 'valida la presencia de password_confirmation si password está presente' do
      profile = Profile.new(password: 'password')
      profile.valid? # Esto corre las validaciones
      expect(profile.errors[:password_confirmation]).to include("can't be blank")
    end
  
    it 'no valida password_confirmation si password no está presente' do
      profile = Profile.new(password: nil)
      profile.valid? # Esto corre las validaciones
      expect(profile.errors[:password_confirmation]).to be_empty
    end
  end

  describe 'Relaciones' do
    it { should have_many(:orders).dependent(:destroy) }
    it { should have_many(:notifications).dependent(:destroy) }
  end

  describe 'Métodos' do
    let(:profile) { create(:profile) }

    describe '#generate_otp_token' do
      it 'genera un token de 6 dígitos y establece otp_expires_at' do
        profile.generate_otp_token
        expect(profile.otp_token).to match(/\A\d{6}\z/)
        expect(profile.otp_expires_at).to be_within(1.second).of(10.minutes.from_now)
      end
    end

    describe '#valid_otp_token?' do
      before { profile.generate_otp_token }

      it 'devuelve true si el token es válido y no está expirado' do
        expect(profile.valid_otp_token?(profile.otp_token)).to be(true)
      end

      it 'devuelve false si el token no coincide' do
        expect(profile.valid_otp_token?('123456')).to be(false)
      end

      it 'devuelve false si el token está expirado' do
        travel_to(11.minutes.from_now) do
          expect(profile.valid_otp_token?(profile.otp_token)).to be(false)
        end
      end
    end

    describe '#increment_failed_otp_attempts' do
      it 'incrementa failed_otp_attempts' do
        expect { profile.increment_failed_otp_attempts }.to change { profile.failed_otp_attempts }.by(1)
      end
    end
  end

  describe 'Callbacks' do
    it 'convierte el email a minúsculas antes de guardar' do
      profile = create(:profile, email: 'TEST@EXAMPLE.COM')
      expect(profile.email).to eq('test@example.com')
    end

    it 'inicializa valores predeterminados después de la inicialización' do
      profile = Profile.new
      expect(profile.failed_otp_attempts).to eq(0)
      expect(profile.two_factor_enabled).to eq(false)
    end
  end

  describe '#generate_reset_token' do
    let(:profile) { create(:profile) }
    it 'generates a unique reset token and sets the timestamp' do
      profile.generate_reset_token
      expect(profile.reset_token).to be_present
      expect(profile.reset_token_sent_at).to be_within(1.second).of(Time.current)
    end

    it 'saves the profile with the new token and timestamp' do
      expect { profile.generate_reset_token }.to change { profile.reload.reset_token }.from(nil).to(be_present)
    end
  end

  describe '#reset_token_expired?' do
    let(:profile) { create(:profile) }
    context 'when the token was generated more than 2 hours ago' do
      it 'returns true' do
        profile.update(reset_token_sent_at: 3.hours.ago)
        expect(profile.reset_token_expired?).to be true
      end
    end

    context 'when the token was generated within 2 hours' do
      it 'returns false' do
        profile.update(reset_token_sent_at: 1.hour.ago)
        expect(profile.reset_token_expired?).to be false
      end
    end
  end

  describe '#clear_reset_token' do
    let(:profile) { create(:profile) }
    it 'clears the reset token and timestamp' do
      profile.update(reset_token: 'test_token', reset_token_sent_at: Time.current)
      profile.clear_reset_token
      expect(profile.reset_token).to be_nil
      expect(profile.reset_token_sent_at).to be_nil
    end

    it 'saves the profile after clearing the token and timestamp' do
      profile.update(reset_token: 'test_token', reset_token_sent_at: Time.current)
      expect { profile.clear_reset_token }.to change { profile.reload.reset_token }.from('test_token').to(nil)
    end
  end  
end
