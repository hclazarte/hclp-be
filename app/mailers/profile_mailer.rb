class ProfileMailer < ApplicationMailer
  include Rails.application.routes.url_helpers

  def send_otp
    @profile = params[:profile]
    @otp_token = @profile.otp_token
    puts(@otp_token)
    mail(to: @profile.email, subject: "Tu código de autenticación")
  end

  def verification_email
    @profile = params[:profile]
    @verification_link = url_for(
      controller: 'new_profiles',
      action: 'verify_email',
      token: @profile.verification_token,
      only_path: false
    )
    mail(to: @profile.email, subject: "Verifica tu correo electrónico")
  end

  def reset_password_email
    @profile = params[:profile]
    @reset_link =url_for(
      controller: 'reset_passwords',
      action: 'update_password',
      token: @profile.reset_token,
      only_path: false
    )
    mail(to: @profile.email, subject: "Restablecimiento de Contraseña")
  end
end
