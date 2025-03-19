module Api
  class GeneralController < ApplicationController
    def ping
      render json: { message: 'API funcionando correctamente' }, status: :ok
    end
  end
end
