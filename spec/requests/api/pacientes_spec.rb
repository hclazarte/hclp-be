require 'swagger_helper'
include PacienteParamsHelper

RSpec.describe "Pacientes API", type: :request do
  let!(:usuario_admin) { create(:usuario, rol: :admin) }
  let!(:pacientes) { create_list(:paciente, 3) }

  let(:token) { Doorkeeper::AccessToken.create!(resource_owner_id: usuario_admin.id, scopes: 'read write') }
  let(:headers) { { "Authorization" => "Bearer #{token.token}", "Content-Type" => "application/json" } }

  describe "PATCH /api/pacientes" do
    it "devuelve una lista de pacientes" do
      patch "/api/pacientes/filtrar?&page=1&per_page=10", headers: headers

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["results"].size).to eq(3)
    end
  end

  describe "GET /api/pacientes/:id" do
    let(:paciente) { pacientes.first }

    it "devuelve la información de un paciente" do
      get "/api/pacientes/#{paciente.id}", headers: headers

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["id"]).to eq(paciente.id)
    end

    it "devuelve 404 si el paciente no existe" do
      get "/api/pacientes/999999", headers: headers

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST /api/pacientes" do
    it "crea un paciente con datos válidos" do
      post "/api/pacientes", params: paciente_valid_params.to_json, headers: headers

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)["email"]).to eq("juan.perez@example.com")
    end

    it "retorna error si faltan datos" do
      post "/api/pacientes", params: { nombre: "" }.to_json, headers: headers

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)).to include("nombre", "apellido_paterno", "cedula", "fecha_nacimiento", "tipo_sangre")
    end
  end

  describe "PUT /api/pacientes/:id" do
    let(:paciente) { pacientes.first }

    it "actualiza un paciente" do
      put "/api/pacientes/#{paciente.id}", params: { nombre: "NuevoNombre" }.to_json, headers: headers

      expect(response).to have_http_status(:ok)
      expect(paciente.reload.nombre).to eq("NuevoNombre")
    end

    it "retorna error si el paciente no existe" do
      put "/api/pacientes/999999", params: { usuario: { nombre: "NuevoNombre" } }.to_json, headers: headers

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "DELETE /api/pacientes/:id" do
    let(:paciente) { pacientes.last }

    it "elimina un paciente" do
      delete "/api/pacientes/#{paciente.id}", headers: headers

      expect(response).to have_http_status(:no_content)
      expect(Usuario.exists?(paciente.id)).to be_falsey
    end

    it "retorna error si el paciente no existe" do
      delete "/api/pacientes/999999", headers: headers

      expect(response).to have_http_status(:not_found)
    end
  end
end
