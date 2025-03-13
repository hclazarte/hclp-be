class Api::UsuariosController < ApplicationController
  before_action :doorkeeper_authorize!, except: [ :create ]
  before_action :set_usuario, only: [ :show, :update, :destroy ]

  # GET /api/usuarios
  def index
    usuarios = Paciente.filter_by(params)
    render json: usuarios
  end

  # GET /api/usuarios/:id
  def show
    render json: @usuario
  end

  # POST /api/usuarios
  def create
    usuario = Usuario.new(usuario_params)
    if usuario.save
      render json: usuario, status: :created
    else
      render json: usuario.errors, status: :unprocessable_entity
    end
  end

  # PUT /api/usuarios/:id
  def update
    if @usuario.update(usuario_params)
      render json: @usuario
    else
      render json: @usuario.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/usuarios/:id
  def destroy
    @usuario.destroy
    head :no_content
  end

  private

  def set_usuario
    @usuario = Usuario.find(params[:id])
  end

  def usuario_params
    params.require(:usuario).permit(:nombre, :apellido_paterno, :email, :password, :rol)
  end
end
