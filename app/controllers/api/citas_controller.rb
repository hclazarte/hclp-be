class Api::CitasController < ApplicationController
  before_action :doorkeeper_authorize!, except: [:create]
  before_action :set_cita, only: [:show, :update, :destroy]

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

  private

  def set_cita
    @cita = Cita.find(params[:id])
  end

  def cita_params
    params.require(:cita).permit(:nombre, :apellido_paterno, :email, :password, :rol)
  end
end
