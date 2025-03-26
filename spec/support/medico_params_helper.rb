# spec/support/medico_params_helper.rb
module MedicoParamsHelper
  def medico_valid_params
    {
      nombre: "Luis",
      apellido_paterno: "Fernandez",
      apellido_materno: "Lopez",
      cedula: "87654321",
      direccion: "Av. Principal 456, Cochabamba",
      movil: "+59176543210",
      email: "luis.fernandez@example.com",
      registro_profesional: "MED123456",
      telefono: "+59122567890",
      estado: 'alta',
      especialidades: [],
      horario_medicos: []
    }
  end
end
