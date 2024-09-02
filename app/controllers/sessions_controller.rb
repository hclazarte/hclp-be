class SessionsController < ApplicationController
  def new
  end

  def create
    profile = Profile.find_by(email: params[:email])

    if profile && profile.authenticate(params[:password])
      session[:profile_id] = profile.id
      redirect_to root_path, notice: "¡Sesión iniciada!"
    else
      flash.now[:alert] = "Correo o contraseña inválidos"
      render :new
    end
  end

  def destroy
    session[:profile_id] = nil
    redirect_to root_path, notice: "¡Sesión cerrada!"
  end
end
