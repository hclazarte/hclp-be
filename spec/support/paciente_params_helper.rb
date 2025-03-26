module PacienteParamsHelper
  def paciente_valid_params
    {
      nombre: "Juan",
      apellido_paterno: "Pérez",
      apellido_materno: "Gómez",
      cedula: "65498732",
      direccion: "Calle Bolívar 789, La Paz",
      movil: "+59176549876",
      email: "juan.perez@example.com",
      password: "password123",
      rol: 2,
      usuario_id: nil,
      estado_civil: "casado",
      ocupacion: "Ingeniero",
      fecha_nacimiento: "1990-05-15",
      lugar_nacimiento: "La Paz, Bolivia",
      telefono: "+59122456789",
      tipo_afiliado: "titular",
      tipo_sangre: "orh_p",
      estado: "alta"
    }
  end
end