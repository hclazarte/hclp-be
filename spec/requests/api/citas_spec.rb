require 'swagger_helper'

RSpec.describe 'Citas API', type: :request do
  let!(:usuario_admin) { create(:usuario, rol: :admin) }
  let!(:medico) { create(:medico) }
  let!(:paciente) { create(:paciente) }
  let!(:citas) { create_list(:cita, 3, medico: medico, paciente: paciente) }

  let(:token) { Doorkeeper::AccessToken.create!(resource_owner_id: usuario_admin.id, scopes: 'read write') }
  let(:headers) { { 'Authorization' => "Bearer #{token.token}", 'Content-Type' => 'application/json' } }

  describe 'GET /api/citas' do
    it 'devuelve una lista de citas' do
      get '/api/citas', headers: headers

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe 'GET /api/citas/:id' do
    let(:cita) { citas.first }

    it 'devuelve la información de una cita' do
      get "/api/citas/#{cita.id}", headers: headers

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['id']).to eq(cita.id)
    end

    it 'devuelve 404 si la cita no existe' do
      get '/api/citas/999999', headers: headers

      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'POST /api/citas' do
    let(:valid_params) do
      {
        fecha: '2025-04-10',
        hora: '10:30',
        motivo: 'Consulta general',
        estado: 'pendiente',
        medico_id: medico.id,
        paciente_id: paciente.id
      }
    end

    it 'crea una cita con datos válidos' do
      post '/api/citas', params: valid_params.to_json, headers: headers

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['estado']).to eq('pendiente')
    end

    it 'retorna error si faltan datos' do
      post '/api/citas', params: { fecha: '' }.to_json, headers: headers

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)).to include('estado', 'fecha', 'hora', 'medico', 'paciente')
    end
  end

  describe 'PUT /api/citas/:id' do
    let(:cita) { citas.first }

    it 'actualiza una cita' do
      put "/api/citas/#{cita.id}", params: { estado: 'confirmada' }.to_json, headers: headers

      expect(response).to have_http_status(:ok)
      expect(cita.reload.estado).to eq('confirmada')
    end

    it 'retorna error si la cita no existe' do
      put '/api/citas/999999', params: { estado: 'confirmada' }.to_json, headers: headers

      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'DELETE /api/citas/:id' do
    let(:cita) { citas.last }

    it 'elimina una cita' do
      delete "/api/citas/#{cita.id}", headers: headers

      expect(response).to have_http_status(:no_content)
      expect(Cita.exists?(cita.id)).to be_falsey
    end

    it 'retorna error si la cita no existe' do
      delete '/api/citas/999999', headers: headers

      expect(response).to have_http_status(:not_found)
    end
  end
end
