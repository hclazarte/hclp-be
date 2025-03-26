module MedicoParamsHelper
  def medico_valid_params
    {
            nombre: "Luis",
            apellido_paterno: "Fernández",
            apellido_materno: "López",
            cedula: "87654321",
            direccion: "Av. Principal 456, Cochabamba",
            movil: "59176543210",
            telefono: "59122567890",
            email: "luis.fernandez@example.com",
            registro_profesional: "MED123456",
            estado: "alta",
            usuario_id: 1,
            especialidades: [],
            horario_medicos: []
    }
  end
end
