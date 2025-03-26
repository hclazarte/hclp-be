require 'swagger_helper'
include {{Entidad}}ParamsHelper

RSpec.describe "{{Entidades}} API", type: :request do
  let!(:usuario_admin) { create(:usuario, rol: :admin) }
  let!(:{{Entidades}}) { create_list(:{{entidad}}, 3) }

  let(:token) { Doorkeeper::AccessToken.create!(resource_owner_id: usuario_admin.id, scopes: 'read write') }
  let(:headers) { { "Authorization" => "Bearer #{token.token}", "Content-Type" => "application/json" } }

  describe "PATCH /api/{{Entidades}}" do
    it "devuelve una lista de {{Entidades}}" do
      patch "/api/{{Entidades}}/filtrar?&page=1&per_page=10", headers: headers

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["results"].size).to eq(3)
    end
  end

  describe "GET /api/{{Entidades}}/:id" do
    let(:{{entidad}}) { {{Entidades}}.first }

    it "devuelve la información de un {{entidad}}" do
      get "/api/{{Entidades}}/#{{{entidad}}.id}", headers: headers

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["id"]).to eq({{entidad}}.id)
    end

    it "devuelve 404 si el {{entidad}} no existe" do
      get "/api/{{Entidades}}/999999", headers: headers

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST /api/{{Entidades}}" do
    it "crea un {{entidad}} con datos válidos" do
      post "/api/{{Entidades}}", params: {{entidad}}_valid_params.to_json, headers: headers

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)).to include({{entidad}}_valid_params.stringify_keys)
    end

    it "retorna error si faltan datos" do
      post "/api/{{Entidades}}", params: { nombre: "" }.to_json, headers: headers
    
      expect(response).to have_http_status(:unprocessable_entity)
    
      errores = JSON.parse(response.body).keys
      campos_validos = {{entidad}}_valid_params.keys.map(&:to_s)
    
      expect(campos_validos).to include(*errores)
    end
  end

  describe "PUT /api/{{Entidades}}/:id" do
    let(:{{entidad}}) { {{Entidades}}.first }

    it "actualiza un {{entidad}}" do
      put "/api/{{Entidades}}/#{{{entidad}}.id}", params: { nombre: "NuevoNombre" }.to_json, headers: headers

      expect(response).to have_http_status(:ok)
      expect({{entidad}}.reload.nombre).to eq("NuevoNombre")
    end

    it "retorna error si el {{entidad}} no existe" do
      put "/api/{{Entidades}}/999999", params: { nombre: "NuevoNombre" }.to_json, headers: headers

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "DELETE /api/{{Entidades}}/:id" do
    let(:{{entidad}}) { {{Entidades}}.last }

    it "elimina un {{entidad}}" do
      delete "/api/{{Entidades}}/#{{{entidad}}.id}", headers: headers

      expect(response).to have_http_status(:no_content)
      expect({{Entidad}}.exists?({{entidad}}.id)).to be_falsey
    end

    it "retorna error si el {{entidad}} no existe" do
      delete "/api/{{Entidades}}/999999", headers: headers

      expect(response).to have_http_status(:not_found)
    end
  end
end
