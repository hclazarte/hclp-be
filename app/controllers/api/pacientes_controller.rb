class Api::PacientesController < ApplicationController
  before_action :doorkeeper_authorize!, except: [ :create ]
  before_action :set_paciente, only: [ :show, :update, :destroy ]

  # GET /api/pacientes
  def index
    pacientes = Medico.filter_by(params)
    render json: pacientes
  end

  # GET /api/pacientes/:id
  def show
    render json: @paciente
  end

  # POST /api/pacientes
  def create
    paciente = Paciente.new(paciente_params)
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
      # Si el paciente tiene usuario, también actualizamos la información en usuarios
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
    params.require(:paciente).permit(:nombre, :apellido_paterno, :email, :password, :rol)
  end
end
