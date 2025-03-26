module PacienteParamsHelper
  def paciente_valid_params
    {
            nombre: "María",
            apellido_paterno: "González",
            cedula: "12345678",
            fecha_nacimiento: "1990-05-15",
            tipo_sangre: "orh_p",
            estado_civil: "soltero",
            tipo_afiliado: "titular",
            estado: "alta",
            usuario_id: 1
    }
  end
end
