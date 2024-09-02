# app/controllers/api/v1/me_controller.rb
module Api
  module V1
    class MeController < ApplicationController
      before_action :doorkeeper_authorize!

      def show
        if current_resource_owner
          render json: current_resource_owner
        else
          head :not_found
        end
      end
    
      private
    
      def current_resource_owner
        @current_resource_owner ||= Profile.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
      end
    end
  end
end
