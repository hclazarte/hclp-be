class ApplicationController < ActionController::API
  before_action :authenticate_resource_owner!, except: [:verify_email]

  private

  def authenticate_resource_owner!
    @current_resource_owner_id = doorkeeper_token&.resource_owner_id
    render json: { error: 'No autenticado' }, status: :unauthorized unless @current_resource_owner_id
  end
end
