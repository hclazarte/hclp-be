class Api::MedicosController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  before_action :doorkeeper_authorize!
  before_action :set_medico,
                only: %i[show update destroy horarios agregar_horario eliminar_horario especialidades agregar_especialidad
                         eliminar_especialidad]

  # PATCH /api/medicos/filtrar
  def filtrar
    page = params[:page].to_i.positive? ? params[:page].to_i : 1
    per_page = params[:per_page].to_i.positive? ? params[:per_page].to_i : 1

    base_query = params[:medico].present? ? Medico.filter_by(medico_params) : Medico.all
    base_query = base_query.order(created_at: :desc)

    if params[:include].present?
      included_id = params[:include].to_i
      base_query = base_query.or(Medico.where(id: included_id)) unless base_query.exists?(id: included_id)
    end

    total_count = base_query.distinct.count
    medicos = base_query.distinct.limit(per_page).offset((page - 1) * per_page)

    render json: {
      page: page,
      per_page: per_page,
      count: total_count,
      results: medicos.as_json(include: %i[horario_medicos especialidades])
    }
  end

  # GET /api/medicos/:id
  def show
    render json: @medico, include: %i[especialidades horario_medicos]
  end

  # POST /api/medicos
  def create
    params[:medico][:especialidades] ||= params[:especialidades]
    params[:medico][:horarios] ||= params[:horario_medicos]

    medico = Medico.new(medico_params)

    # Si el usuario_id está presente, verificar y actualizar datos redundantes
    if medico.usuario_id.present?
      usuario = Usuario.find_by(id: medico.usuario_id)

      return render json: { error: 'Usuario no encontrado' }, status: :unprocessable_entity unless usuario

      # Si algún campo en usuario es distinto, actualizarlo
      usuario.update!(
        nombre: medico.nombre,
        apellido_paterno: medico.apellido_paterno,
        apellido_materno: medico.apellido_materno,
        cedula: medico.cedula,
        direccion: medico.direccion,
        movil: medico.movil,
        email: medico.email
      )

    end

    if medico.save
      # Asociar Especialidades
      if params[:medico][:especialidades].present?
        params[:medico][:especialidades].each do |esp|
          medico.medico_especialidades.create!(especialidad_id: esp[:id])
        end
      end
      # Crear Horarios para el Médico
      if params[:medico][:horarios].present?
        params[:medico][:horarios].each do |horario|
          medico.horario_medicos.create!(
            dia: horario[:dia],
            hora_inicio: horario[:hora_inicio],
            hora_fin: horario[:hora_fin]
          )
        end
      end

      render json: medico, include: %i[especialidades horario_medicos], status: :created
    else
      render json: medico.errors, status: :unprocessable_entity
    end
  end

  # PUT /api/medicos/:id
  def update
    medico = Medico.find(params[:id])

    if medico.update(medico_params)
      # Actualizar especialidades si se mandaron
      if params[:especialidades].present?
        especialidad_ids = params[:especialidades].map { |esp| esp[:id] || esp["id"] }.uniq
        medico.especialidades = Especialidad.where(id: especialidad_ids)
      end

      # Actualizar horarios si se mandaron
      if params[:horario_medicos].present?
        # Limpiar horarios anteriores y recrear
        medico.horario_medicos.destroy_all

        params[:horario_medicos].each do |h|
          medico.horario_medicos.create!(
            dia: h[:dia],
            hora_inicio: h[:hora_inicio],
            hora_fin: h[:hora_fin]
          )
        end
      end

      # Si tiene usuario asociado, actualizarlo también
      if medico.usuario
        medico.usuario.update(
          nombre: medico.nombre,
          apellido_paterno: medico.apellido_paterno,
          apellido_materno: medico.apellido_materno,
          cedula: medico.cedula,
          direccion: medico.direccion,
          movil: medico.movil,
          email: medico.email
        )
      end

      render json: medico, include: %i[especialidades horario_medicos]
    else
      render json: medico.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/medicos/:id
  def destroy
    @medico.destroy
    head :no_content
  end

  # Gestión de Horarios
  def horarios
    render json: @medico.horario_medicos
  end

  def agregar_horario
    horario = @medico.horario_medicos.new(horario_params)
    if horario.save
      render json: horario, status: :created
    else
      render json: horario.errors, status: :unprocessable_entity
    end
  end

  def eliminar_horario
    horario = @medico.horario_medicos.find(params[:id])
    horario.destroy
    head :no_content
  end

  # 📌 Gestión de Especialidades
  def especialidades
    render json: @medico.especialidades
  end

  def agregar_especialidad
    especialidad = Especialidad.find(params[:especialidad_id])
    @medico.especialidades << especialidad unless @medico.especialidades.include?(especialidad)
    render json: @medico.especialidades
  end

  def eliminar_especialidad
    especialidad = @medico.especialidades.find(params[:id])
    @medico.especialidades.delete(especialidad)
    head :no_content
  end

  private

  def set_medico
    @medico = Medico.find(params[:id])
  end

  def medico_params
    params.require(:medico).permit(
      :registro_profesional,
      :telefono,
      :telefono2,
      :estado,
      :usuario_id,
      :nombre,
      :apellido_paterno,
      :apellido_materno,
      :cedula,
      :direccion,
      :movil,
      :email,
      medico_especialidades_attributes: [:especialidad_id],
      horario_medicos_attributes: %i[dia hora_inicio hora_fin]
    )
  end

  def horario_params
    params.require(:horario_medico).permit(:dia, :hora_inicio, :hora_fin)
  end
end
