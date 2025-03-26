require 'swagger_helper'
include {{S_Entidad_s}}ParamsHelper

RSpec.describe "{{P_Entidad_p}} API", type: :request do
  let!(:usuario_admin) { create(:usuario, rol: :admin) }
  let!(:{{p_entidad_p}}) { create_list(:{{s_entidad_s}}, 3) }

  let(:token) { Doorkeeper::AccessToken.create!(resource_owner_id: usuario_admin.id, scopes: 'read write') }
  let(:headers) { { "Authorization" => "Bearer #{token.token}", "Content-Type" => "application/json" } }

  describe "PATCH /api/{{p_entidad_p}}" do
    it "devuelve una lista de {{p_entidad_p}}" do
      patch "/api/{{p_entidad_p}}/filtrar?&page=1&per_page=10", headers: headers

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["results"].size).to eq(3)
    end
  end

  describe "GET /api/{{p_entidad_p}}/:id" do
    let(:{{s_entidad_s}}) { {{p_entidad_p}}.first }

    it "devuelve la información de un {{s_entidad_s}}" do
      get "/api/{{p_entidad_p}}/#{{{s_entidad_s}}.id}", headers: headers

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["id"]).to eq({{s_entidad_s}}.id)
    end

    it "devuelve 404 si el {{s_entidad_s}} no existe" do
      get "/api/{{p_entidad_p}}/999999", headers: headers

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST /api/{{p_entidad_p}}" do
    it "crea un {{s_entidad_s}} con datos válidos" do
      post "/api/{{p_entidad_p}}", params: {{s_entidad_s}}_valid_params.to_json, headers: headers
      
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)).to include({{s_entidad_s}}_valid_params.stringify_keys)
    end

    it "retorna error si faltan datos" do
      post "/api/{{p_entidad_p}}", params: { nombre: "" }.to_json, headers: headers
    
      expect(response).to have_http_status(:unprocessable_entity)
    
      errores = JSON.parse(response.body).keys
      campos_validos = {{s_entidad_s}}_valid_params.keys.map(&:to_s)
    
      expect(campos_validos).to include(*errores)
    end
  end

  describe "PUT /api/{{p_entidad_p}}/:id" do
    let(:{{s_entidad_s}}) { {{p_entidad_p}}.first }

    it "actualiza un {{s_entidad_s}}" do
      put "/api/{{p_entidad_p}}/#{{{s_entidad_s}}.id}", params: { nombre: "NuevoNombre" }.to_json, headers: headers

      expect(response).to have_http_status(:ok)
      expect({{s_entidad_s}}.reload.nombre).to eq("NuevoNombre")
    end

    it "retorna error si el {{s_entidad_s}} no existe" do
      put "/api/{{p_entidad_p}}/999999", params: { nombre: "NuevoNombre" }.to_json, headers: headers

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "DELETE /api/{{p_entidad_p}}/:id" do
    let(:{{s_entidad_s}}) { {{p_entidad_p}}.last }

    it "elimina un {{s_entidad_s}}" do
      delete "/api/{{p_entidad_p}}/#{{{s_entidad_s}}.id}", headers: headers

      expect(response).to have_http_status(:no_content)
      expect({{S_Entidad_s}}.exists?({{s_entidad_s}}.id)).to be_falsey
    end

    it "retorna error si el {{s_entidad_s}} no existe" do
      delete "/api/{{p_entidad_p}}/999999", headers: headers

      expect(response).to have_http_status(:not_found)
    end
  end
end
