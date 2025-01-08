class ResetPasswordsController < ApplicationController
  # POST /reset_passwords/request_reset
  def request_reset
    @profile = Profile.find_by(email: params[:email])

    if @profile
      @profile.generate_reset_token
      ProfileMailer.with(profile: @profile).reset_password_email.deliver_now
      render json: { message: "Correo de restablecimiento de contraseña enviado." }, status: :ok
    else
      render json: { error: "El correo no está registrado." }, status: :not_found
    end
  end

  # PATCH /reset_passwords/update_password
  def update_password
    @profile = Profile.find_by(reset_token: params[:token])

    if @profile.nil? || @profile.reset_token_expired?
      render json: { error: "Token inválido o expirado." }, status: :unprocessable_entity
    elsif @profile.update(password: params[:password], password_confirmation: params[:password_confirmation])
      @profile.clear_reset_token
      render json: { message: "Contraseña actualizada exitosamente." }, status: :ok
    else
      render json: { errors: @profile.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
