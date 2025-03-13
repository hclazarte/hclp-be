class Api::MedicosController < ApplicationController
  before_action :doorkeeper_authorize!
  before_action :set_medico, only: [ :show, :update, :destroy, :horarios, :agregar_horario, :eliminar_horario, :especialidades, :agregar_especialidad, :eliminar_especialidad ]

  # GET /api/medicos
  def index
    medicos = Medico.filter_by(params)
    render json: medicos, include: [ :especialidades, :horario_medicos ]
  end

  # GET /api/medicos/:id
  def show
    render json: @medico, include: [ :especialidades, :horario_medicos ]
  end

  # POST /api/medicos
  def create
    medico = Medico.new(medico_params)
    if medico.save
      render json: medico, status: :created
    else
      render json: medico.errors, status: :unprocessable_entity
    end
  end

  # PUT /api/medicos/:id
  def update
    medico = Medico.find(params[:id])
    if medico.update(medico_params)
      # Si el medico tiene usuario, actualizamos en usuarios
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
      render json: medico
    else
      render json: medico.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/medicos/:id
  def destroy
    @medico.destroy
    head :no_content
  end

  # 📌 Gestión de Horarios
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
    params.require(:medico).permit(:nombre, :email)
  end

  def horario_params
    params.require(:horario_medico).permit(:dia, :hora_inicio, :hora_fin)
  end
end
