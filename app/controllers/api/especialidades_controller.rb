class Api::EspecialidadesController < ApplicationController
  before_action :doorkeeper_authorize!, except: [:create]
  before_action :set_especialidad, only: [:show, :update, :destroy]

  # GET /api/especialidades
  def index
    especialidades = Especialidad.all
    render json: especialidades
  end

  # GET /api/especialidades/:id
  def show
    render json: @especialidad
  end

  # POST /api/especialidades
  def create
    especialidad = Especialidad.new(especialidad_params)
    if especialidad.save
      render json: especialidad, status: :created
    else
      render json: especialidad.errors, status: :unprocessable_entity
    end
  end

  # PUT /api/especialidades/:id
  def update
    if @especialidad.update(especialidad_params)
      render json: @especialidad
    else
      render json: @especialidad.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/especialidades/:id
  def destroy
    @especialidad.destroy
    head :no_content
  end

  private

  def set_especialidad
    @especialidad = Especialidad.find(params[:id])
  end

  def especialidad_params
    params.require(:especialidad).permit(:nombre, :apellido_paterno, :email, :password, :rol)
  end  
end
