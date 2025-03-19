require 'swagger_helper'

RSpec.describe 'API de Prueba', type: :request do
  path '/api/ping' do
    get 'Verifica si la API está activa' do
      tags 'General'
      produces 'application/json'

      response(200, 'OK') do
        run_test!
      end
    end
  end
end
