class Api::CitasController < ApplicationController
  before_action :doorkeeper_authorize!, except: [ :create ]
  before_action :set_cita, only: [ :show, :update, :destroy ]

  # GET /api/citas
  def index
    citas = Cita.all
    render json: citas
  end

  # GET /api/citas/:id
  def show
    render json: @cita
  end

  # POST /api/citas
  def create
    cita = Cita.new(cita_params)
    if cita.save
      render json: cita, status: :created
    else
      render json: cita.errors, status: :unprocessable_entity
    end
  end

  # PUT /api/citas/:id
  def update
    if @cita.update(cita_params)
      render json: @cita
    else
      render json: @cita.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/citas/:id
  def destroy
    @cita.destroy
    head :no_content
  end

  # GET /api/citas/disponibles
  def disponibles
    especialidad = Especialidad.find_by(id: params[:especialidad_id])

    if especialidad.nil?
      return render json: { error: "Especialidad no encontrada" }, status: :not_found
    end

    # Obtener médicos con la especialidad dada
    medicos = especialidad.medicos.includes(:horario_medicos)

    citas_disponibles = []

    medicos.each do |medico|
      medico.horario_medicos.each do |horario|
        hora_actual = horario.hora_inicio

        while hora_actual < horario.hora_fin
          citas_disponibles << {
            medico_id: medico.id,
            especialidad_id: especialidad.id,
            medico_nombre: "#{medico.nombre} #{medico.apellido_paterno}",
            especialidad: especialidad.nombre,
            dia: horario.dia,
            hora: hora_actual.strftime("%H:%M")
          }

          # Avanza 45 minutos (duración de la cita)
          hora_actual += 45.minutes
        end
      end
    end

    # Obtener los próximos 7 días
    hoy = Date.today
    dias_siguientes = (0..6).map { |i| hoy + i }

    # Mapeo de nombres de días en español a objetos Date
    dias_map = {
      "Domingo" => 0, "Lunes" => 1, "Martes" => 2, "Miércoles" => 3,
      "Jueves" => 4, "Viernes" => 5, "Sábado" => 6
    }

    # Filtrar citas dentro de los próximos 7 días
    citas_proximas = citas_disponibles.map do |cita|
      # Encontrar la fecha correspondiente al día de la semana
      fecha = dias_siguientes.find { |d| d.wday == dias_map[cita[:dia]] }

      # Agregar la fecha a la cita si está dentro de los próximos 7 días
      if fecha
        cita.merge(fecha: fecha.strftime("%Y-%m-%d"))
      end
    end.compact

    # Obtener las citas existentes en la BD con formato estandarizado
    citas_existentes = Cita.pluck(:medico_id, :fecha, :hora).map do |c|
      {
        medico_id: c[0].to_i,  # Asegurar que es un entero
        fecha: c[1].strftime("%Y-%m-%d"), # Asegurar formato correcto de fecha como String
        hora: c[2].strftime("%H:%M") # Convertir la hora a solo "HH:MM" como String
      }
    end

    # Filtrar citas_proximas eliminando las citas que ya existen en la BD
    citas_proximas_filtradas = citas_proximas.reject do |cita|
      citas_existentes.any? do |existente|
        existente[:medico_id] == cita[:medico_id].to_i &&
          existente[:fecha] == cita[:fecha].to_s &&
          existente[:hora] == cita[:hora].to_s
      end
    end

    render json: citas_proximas_filtradas
  end

  private

  def set_cita
    @cita = Cita.find(params[:id])
  end

  def cita_params
    params.require(:cita).permit(
      :paciente_id,
      :medico_id,
      :especialidad_id,
      :fecha,
      :hora,
      :estado
    )
  end
end
