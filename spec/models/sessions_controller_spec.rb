require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:profile) { create(:profile) }
  let(:client_app) { create(:oauth_application) }

  describe "POST #create" do
    context "cuando las credenciales son válidas y 2FA está habilitado" do
      it "genera un token de 2FA y envía un correo" do
        expect(ProfileMailer).to receive(:with).and_call_original

        post :create, params: { email: profile.email, password: "password123" }
        expect(response).to have_http_status(:ok)
        expect(profile.reload.otp_token).to be_present
      end
    end

    context "cuando las credenciales son inválidas" do
      it "devuelve un error" do
        post :create, params: { email: profile.email, password: "wrong_password" }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "POST #verify_otp" do
    before do
      profile.generate_otp_token
    end

    context "cuando el token es válido" do
      it "genera un token de Doorkeeper y resetea los intentos fallidos" do
        post :verify_otp, params: { email: profile.email, otp_token: profile.otp_token, client_id: client_app.uid }
        expect(response).to have_http_status(:ok)

        json = JSON.parse(response.body)
        expect(json["access_token"]).to be_present
        expect(profile.reload.failed_otp_attempts).to eq(0)
      end
    end

    context "cuando el token es inválido" do
      it "incrementa los intentos fallidos y devuelve un error" do
        post :verify_otp, params: { email: profile.email, otp_token: "wrong_token", client_id: client_app.uid }
        expect(response).to have_http_status(:unauthorized)
        expect(profile.reload.failed_otp_attempts).to eq(1)
      end
    end

    context "cuando se superan los intentos fallidos" do
      it "devuelve un error y bloquea la verificación" do
        Rails.application.config.two_factor_max_attempts = 3
        profile.update!(failed_otp_attempts: 3)

        post :verify_otp, params: { email: profile.email, otp_token: profile.otp_token, client_id: client_app.uid }
        expect(response).to have_http_status(:forbidden)

        json = JSON.parse(response.body)
        expect(json["error"]).to eq("Demasiados intentos fallidos. Intenta nuevamente más tarde.")
      end
    end
  end
end
