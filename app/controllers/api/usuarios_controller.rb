class Api::UsuariosController < ApplicationController
  before_action :doorkeeper_authorize!, except: [:create]
  before_action :set_usuario, only: %i[show update destroy]

  # PATCH /api/usuarios/filtrar
  def filtrar
    page = params[:page].to_i.positive? ? params[:page].to_i : 1
    per_page = params[:per_page].to_i.positive? ? params[:per_page].to_i : 15

    # Extraer los filtros dentro de "usuario"
    usuario_filtros = params.dig(:usuario) || {}

    # Filtrar si hay datos en "usuario", sino devolver todos
    usuarios_query = usuario_filtros.present? ? Usuario.filter_by(usuario_filtros) : Usuario.all
    total_count = usuarios_query.count # Total de registros

    usuarios = usuarios_query.limit(per_page).offset((page - 1) * per_page) # Paginación manual

    render json: {
      page: page,
      per_page: per_page,
      count: total_count,
      results: usuarios
    }
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
    params.require(:usuario).permit(:nombre, :apellido_paterno, :apellido_materno, :cedula, :direccion, :movil, :email,
                                    :password, :rol)
  end
end
