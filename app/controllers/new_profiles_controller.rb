class NewProfilesController < ApplicationController
  before_action :authenticate_user!, except: [:create, :verify_email, :resend_verification]

  # POST /profiles
  def create
    @profile = Profile.new(profile_params.merge(status: :pending, user_role: :manager)) # Usa símbolos para los enums
    if @profile.save
      ProfileMailer.with(profile: @profile).verification_email.deliver_now
      render json: { message: "Perfil creado exitosamente. Por favor, revisa tu correo para las instrucciones de verificación." }, status: :created
    else
      render json: { errors: @profile.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # GET /profiles/verify_email
  def verify_email
    @profile = Profile.find_by(verification_token: params[:token])

    if @profile.nil?
      render json: { error: "Token inválido o expirado." }, status: :unprocessable_entity
    elsif @profile.token_expired?
      render json: { error: "El token ha expirado. Por favor, solicita un nuevo correo de verificación." }, status: :unprocessable_entity
    else
      @profile.mark_as_verified
      render json: { message: "Correo verificado exitosamente." }, status: :ok
    end
  end

  # POST /profiles/resend_verification
  def resend_verification
    @profile = Profile.find_by(email: params[:email])

    if @profile.nil?
      render json: { error: "Perfil no encontrado." }, status: :not_found
    elsif @profile.email_verified
      render json: { error: "El correo ya ha sido verificado." }, status: :unprocessable_entity
    else
      @profile.generate_verification_token
      @profile.save
      ProfileMailer.with(profile: @profile).verification_email.deliver_now
      render json: { message: "Correo de verificación reenviado exitosamente." }, status: :ok
    end
  end

  private

  # Strong Parameters
  def profile_params
    params.require(:profile).permit(:full_name, :email, :phone, :address, :city, :state, :postal_code, :password, :password_confirmation)
  end
end
