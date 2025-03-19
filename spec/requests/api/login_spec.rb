require 'swagger_helper'

RSpec.describe "Login API", type: :request do
  let!(:usuario) { create(:usuario, email: "test@example.com", password: "password123") }

  describe "POST /api/login" do
    context "cuando las credenciales son válidas" do
      it "devuelve un token de acceso" do
        post "/api/login", params: { email: usuario.email, password: "password123" }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to have_key("access_token")
      end
    end

    context "cuando las credenciales son inválidas" do
      it "devuelve un error de autenticación" do
        post "/api/login", params: { email: usuario.email, password: "wrongpassword" }

        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)).to have_key("error")
      end
    end
  end
end
