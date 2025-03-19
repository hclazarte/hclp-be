class Api::PacientesController < ApplicationController
  before_action :doorkeeper_authorize!, except: [ :create ]
  before_action :set_paciente, only: [ :show, :update, :destroy ]

  # GET /api/pacientes
  def index
    page = params[:page].to_i.positive? ? params[:page].to_i : 1
    per_page = params[:per_page].to_i.positive? ? params[:per_page].to_i : 1

    pacientes_query = params[:paciente].present? ? Paciente.filter_by(paciente_params) : Paciente.all
    total_count = pacientes_query.count # Total de registros

    pacientes = pacientes_query.limit(per_page).offset((page - 1) * per_page) # Paginación manual

    render json: {
      page: page,
      per_page: per_page,
      count: total_count,
      results: pacientes
    }
  end

  # GET /api/pacientes/:id
  def show
    render json: @paciente
  end

  # POST /api/pacientes
  def create
    paciente = Paciente.new(paciente_params)

    # Si el usuario_id está presente, verificar y actualizar datos redundantes
    if paciente.usuario_id.present?
      paciente = Usuario.find_by(id: paciente.usuario_id)

      if paciente
        # Si algún campo en usuario es distinto, actualizarlo
        usuario.update!(
          nombre: paciente.nombre,
          apellido_paterno: paciente.apellido_paterno,
          apellido_materno: paciente.apellido_materno,
          cedula: paciente.cedula,
          direccion: paciente.direccion,
          movil: paciente.movil,
          email: paciente.email
        )
      else
        return render json: { error: "Usuario no encontrado" }, status: :unprocessable_entity
      end
    end

    if paciente.save
      render json: paciente, status: :created
    else
      render json: paciente.errors, status: :unprocessable_entity
    end
  end


  # PUT /api/pacientes/:id
  def update
    paciente = Paciente.find(params[:id])
    if paciente.update(paciente_params)
      # Si el paciente tiene usuario, también actualizamos la información en usuario
      if paciente.usuario
        paciente.usuario.update(
          nombre: paciente.nombre,
          apellido_paterno: paciente.apellido_paterno,
          apellido_materno: paciente.apellido_materno,
          cedula: paciente.cedula,
          direccion: paciente.direccion,
          movil: paciente.movil,
          email: paciente.email
        )
      end
      render json: paciente
    else
      render json: paciente.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/pacientes/:id
  def destroy
    @paciente.destroy
    head :no_content
  end

  private

  def set_paciente
    @paciente = Paciente.find(params[:id])
  end

  def paciente_params
    params.require(:paciente).permit(
      :nombre,
      :apellido_paterno,
      :apellido_materno,
      :cedula,
      :direccion,
      :movil,
      :email,
      :password,
      :rol,
      :usuario_id,
      :estado_civil,
      :ocupacion,
      :fecha_nacimiento,
      :lugar_nacimiento,
      :telefono,
      :tipo_afiliado,
      :tipo_sangre,
      :estado,
    )
  end
end
