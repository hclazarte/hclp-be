module UsuarioParamsHelper
  def usuario_valid_params
    {
            nombre: "Juan",
            apellido_paterno: "Pérez",
            email: "juan.perez@example.com",
            password: "secret123",
            rol: "paciente"
    }
  end
end
