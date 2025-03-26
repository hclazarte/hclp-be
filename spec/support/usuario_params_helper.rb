module UsuarioParamsHelper
  def usuario_valid_params
    {
      usuario: {
        nombre: "Carlos",
        apellido_paterno: "Lopez",
        email: "carlos@example.com",
        password: "securepassword123",
        rol: 1
      }
    }  
  end
end