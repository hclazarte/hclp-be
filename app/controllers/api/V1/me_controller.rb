module Api
  module V1
    class MeController < ApplicationController
      before_action :doorkeeper_authorize!

      # GET /api/v1/me
      def show
        render json: current_resource_owner
      end

      # PATCH/PUT /api/v1/me
      def update
        if current_resource_owner.update(profile_params)
          render json: current_resource_owner
        else
          render json: current_resource_owner.errors, status: :unprocessable_entity
        end
      end

      private

      def profile_params
        # Asegúrate de adaptar esta lista para permitir solo los parámetros que deben ser actualizables.
        params.require(:profile).permit(:full_name, :email, :phone, :address, :city, :state, :postal_code, :password, :password_confirmation)
      end

      def current_resource_owner
        @current_resource_owner ||= Profile.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
      end
    end
  end
end
