class SessionsController < ApplicationController
  skip_before_action :authenticate_resource_owner!, only: [:create, :verify_otp]

  def create
    profile = Profile.find_by(email: params[:email])
  
    if profile && profile.authenticate(params[:password])
      if profile.two_factor_enabled
        # Generar y enviar el token de 2FA
        profile.generate_otp_token
        ProfileMailer.with(profile: profile).send_otp.deliver_now
  
        render json: { message: "Se ha enviado un token a tu correo" }, status: :ok
      else
        # Omitir 2FA y generar directamente el token de Doorkeeper
        client_app = Doorkeeper::Application.find_by(uid: params[:client_id])
        access_token = Doorkeeper::AccessToken.create!(
          resource_owner_id: profile.id,
          application_id: client_app.id,
          expires_in: Doorkeeper.configuration.access_token_expires_in.to_i,
          scopes: ''
        )
  
        render json: {
          access_token: access_token.token,
          token_type: "Bearer",
          expires_in: access_token.expires_in
        }, status: :ok
      end
    else
      render json: { error: "Credenciales inválidas" }, status: :unauthorized
    end
  end

  def verify_otp
    profile = Profile.find_by(email: params[:email])
  
    if profile
      if profile.exceeded_max_otp_attempts?
        render json: { error: "Demasiados intentos fallidos. Intenta nuevamente más tarde." }, status: :forbidden
      elsif profile.valid_otp_token?(params[:otp_token])
        profile.clear_otp_token
        profile.reset_failed_otp_attempts
  
        # Generar el token de Doorkeeper
        client_app = Doorkeeper::Application.find_by(uid: params[:client_id])
        access_token = Doorkeeper::AccessToken.create!(
          resource_owner_id: profile.id,
          application_id: client_app.id,
          expires_in: Doorkeeper.configuration.access_token_expires_in.to_i,
          scopes: ''
        )
  
        render json: {
          access_token: access_token.token,
          token_type: "Bearer",
          expires_in: access_token.expires_in
        }, status: :ok
      else
        profile.increment_failed_otp_attempts
        render json: { error: "Token inválido" }, status: :unauthorized
      end
    else
      render json: { error: "Usuario no encontrado" }, status: :unauthorized
    end
  end  

  def destroy
    session[:profile_id] = nil
    redirect_to root_path, notice: "¡Sesión cerrada!"
  end
end
