module CitaParamsHelper
  def cita_valid_params
    {
            fecha: "2025-04-15",
            hora: "14:30",
            estado: "pendiente",
            paciente_id: 1,
            medico_id: 2
    }
  end
end
