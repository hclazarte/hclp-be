class ProfileMailer < ApplicationMailer
  def send_otp
    @profile = params[:profile]
    @otp_token = @profile.otp_token
    puts(@otp_token)
    mail(to: @profile.email, subject: "Tu código de autenticación")
  end
end
