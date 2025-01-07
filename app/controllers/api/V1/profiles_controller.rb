module Api
  module V1
    class ProfilesController < ActionController::API
      before_action :doorkeeper_authorize!
      before_action :set_profile, only: [:show, :update, :destroy]

      # No autenticación requerida para la creación de un perfil
      # El index y show pueden seguir sin autenticación según tu necesidad

      def index
        profiles = Profile.all
        render json: profiles
      end

      # Permitir la creación de un perfil sin autenticación
      def create
        @profile = Profile.new(profile_params)
      
        if @profile.save
          render json: @profile, status: :created
        else
          render json: @profile.errors, status: :unprocessable_entity
        end
      end
      

      def show
        render json: @profile
      end

      def update
        if @profile.update(profile_params)
          render json: @profile
        else
          render json: @profile.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @profile.destroy
        head :no_content
      end

      private

      def set_profile
        @profile = Profile.find(params[:id])
      end

      def profile_params
        params.require(:profile).permit(:full_name, :email, :phone, :address, :city, :state, :postal_code, :password, :password_confirmation)
      end        
    end
  end
end
