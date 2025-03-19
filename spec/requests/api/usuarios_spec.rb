require 'rails_helper'

RSpec.describe "Usuarios API", type: :request do
  let!(:usuario_admin) { create(:usuario, rol: :admin) }
  let!(:usuarios) { create_list(:usuario, 3) } # Crea 3 usuarios de prueba

  # Token de acceso con Doorkeeper
  let(:token) { Doorkeeper::AccessToken.create!(resource_owner_id: usuario_admin.id, scopes: 'read write') }
  let(:headers) { { "Authorization" => "Bearer #{token.token}", "Content-Type" => "application/json" } }

  describe "GET /api/usuarios" do
    it "devuelve una lista de usuarios" do
      get "/api/usuarios", headers: headers

      puts "RESPONSE BODY: #{response.body}"
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(4) # 3 usuarios + 1 admin
    end
  end

  describe "GET /api/usuarios/:id" do
    let(:usuario) { usuarios.first }

    it "devuelve la información de un usuario" do
      get "/api/usuarios/#{usuario.id}", headers: headers

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["id"]).to eq(usuario.id)
    end

    it "devuelve 404 si el usuario no existe" do
      get "/api/usuarios/999999", headers: headers

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST /api/usuarios" do
    let(:valid_params) do
      {
        usuario: {
          nombre: "Carlos",
          apellido_paterno: "Lopez",
          email: "carlos@example.com",
          password: "securepassword123",
          rol: 1
        }
      }
    end

    it "crea un usuario con datos válidos" do
      post "/api/usuarios", params: valid_params.to_json, headers: headers

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)["email"]).to eq("carlos@example.com")
    end

    it "retorna error si faltan datos" do
      post "/api/usuarios", params: { usuario: { nombre: "" } }.to_json, headers: headers

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)).to include("password", "nombre", "apellido_paterno", "email")
    end
  end

  describe "PUT /api/usuarios/:id" do
    let(:usuario) { usuarios.first }

    it "actualiza un usuario" do
      put "/api/usuarios/#{usuario.id}", params: { nombre: "NuevoNombre" }.to_json, headers: headers

      expect(response).to have_http_status(:ok)
      expect(usuario.reload.nombre).to eq("NuevoNombre")
    end

    it "retorna error si el usuario no existe" do
      put "/api/usuarios/999999", params: { nombre: "NuevoNombre" }.to_json, headers: headers

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "DELETE /api/usuarios/:id" do
    let(:usuario) { usuarios.last }

    it "elimina un usuario" do
      delete "/api/usuarios/#{usuario.id}", headers: headers

      expect(response).to have_http_status(:no_content)
      expect(Usuario.exists?(usuario.id)).to be_falsey
    end

    it "retorna error si el usuario no existe" do
      delete "/api/usuarios/999999", headers: headers

      expect(response).to have_http_status(:not_found)
    end
  end
end
