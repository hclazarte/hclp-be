class Api::SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    usuario = Usuario.find_by(email: params[:email])
    
    if usuario&.authenticate(params[:password])
      access_token = Doorkeeper::AccessToken.create!(
        resource_owner_id: usuario.id,
        application_id: nil, 
        expires_in: 2.hours,
        scopes: 'read write'
      )

      render json: { access_token: access_token.token, token_type: 'Bearer', expires_in: access_token.expires_in }
    else
      render json: { error: 'Credenciales inválidas' }, status: :unauthorized
    end
  end
end
