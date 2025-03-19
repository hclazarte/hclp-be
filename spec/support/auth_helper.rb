module AuthHelper
  def obtener_token_valido(usuario = nil)
    usuario ||= Usuario.create!(
      email: "test@example.com",
      password: "password123",
      rol: 1 # Un rol válido en tu sistema (ejemplo: médico)
    )

    # Crear una aplicación de Doorkeeper si es necesario
    app = Doorkeeper::Application.create!(name: "TestApp", redirect_uri: "", scopes: "")

    # Crear un token de acceso válido
    Doorkeeper::AccessToken.create!(
      resource_owner_id: usuario.id,
      application_id: app.id,
      expires_in: 2.hours,
      scopes: "read write"
    ).token
  end
end
