require 'swagger_helper'

RSpec.describe "Medicos API", type: :request do
  let!(:usuario_admin) { create(:usuario, rol: :admin) }
  let!(:medicos) { create_list(:medico, 3) }

  let(:token) { Doorkeeper::AccessToken.create!(resource_owner_id: usuario_admin.id, scopes: 'read write') }
  let(:headers) { { "Authorization" => "Bearer #{token.token}", "Content-Type" => "application/json" } }

  describe "PATCH /api/medicos" do
    it "devuelve una lista de medicos" do
      patch "/api/medicos/filtrar?&page=1&per_page=10", headers: headers

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["results"].size).to eq(3)
    end
  end

  describe "GET /api/medicos/:id" do
    let(:medico) { medicos.first }

    it "devuelve la información de un medico" do
      get "/api/medicos/#{medico.id}", headers: headers

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["id"]).to eq(medico.id)
    end

    it "devuelve 404 si el medico no existe" do
      get "/api/medicos/999999", headers: headers

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST /api/medicos" do
    let(:valid_params) do
      {
        nombre: "Luis",
        apellido_paterno: "Fernandez",
        apellido_materno: "Lopez",
        cedula: "87654321",
        direccion: "Av. Principal 456, Cochabamba",
        movil: "+59176543210",
        email: "luis.fernandez@example.com",
        registro_profesional: "MED123456",
        telefono: "+59122567890",
        especialidades: [
            {
                id: 1,
                nombre: "Cardiología",
                descripcion: "Especialidad en enfermedades del corazón"
            }
        ],
        horario_medicos: []
    }
    end

    it "crea un medico con datos válidos" do
      post "/api/medicos", params: valid_params.to_json, headers: headers

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)["email"]).to eq("luis.fernandez@example.com")
    end

    it "retorna error si faltan datos" do
      post "/api/medicos", params: { nombre: "" }.to_json, headers: headers

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)).to include("nombre", "apellido_paterno", "cedula", "registro_profesional")
    end
  end

  describe "PUT /api/medicos/:id" do
    let(:medico) { medicos.first }

    it "actualiza un medico" do
      put "/api/medicos/#{medico.id}", params: { nombre: "Dr. NuevoNombre" }.to_json, headers: headers

      expect(response).to have_http_status(:ok)
      expect(medico.reload.nombre).to eq("Dr. NuevoNombre")
    end

    it "retorna error si el medico no existe" do
      put "/api/medicos/999999", params: { nombre: "Dr. NuevoNombre" }.to_json, headers: headers

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "DELETE /api/medicos/:id" do
    let(:medico) { medicos.last }

    it "elimina un medico" do
      delete "/api/medicos/#{medico.id}", headers: headers

      expect(response).to have_http_status(:no_content)
      expect(Medico.exists?(medico.id)).to be_falsey
    end

    it "retorna error si el medico no existe" do
      delete "/api/medicos/999999", headers: headers

      expect(response).to have_http_status(:not_found)
    end
  end
end
