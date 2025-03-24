class Api::UsuariosController < ApplicationController
  before_action :doorkeeper_authorize!, except: [:create]
  before_action :set_usuario, only: %i[show update destroy]

  # PATCH /api/usuarios/filtrar
  def filtrar
    page = params[:page].to_i.positive? ? params[:page].to_i : 1
    per_page = params[:per_page].to_i.positive? ? params[:per_page].to_i : 1

    base_query = params[:usuario].present? ? Usuario.filter_by(usuario_params) : Usuario.all
    base_query = base_query.order(created_at: :desc)

    if params[:include].present?
      included_id = params[:include].to_i
      base_query = base_query.or(Usuario.where(id: included_id)) unless base_query.exists?(id: included_id)
    end

    total_count = base_query.distinct.count
    usuarios = base_query.distinct.limit(per_page).offset((page - 1) * per_page)

    render json: {
      page: page,
      per_page: per_page,
      count: total_count,
      results: usuarios.as_json
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
