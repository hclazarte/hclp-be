module Api
  module V1
    class ProfilesController < ActionController::API
      before_action :set_profile, only: [:show, :update, :destroy]
      before_action :authenticate_profile!

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
      
      def current_profile
        if current_profile
          render json: current_profile
        else
          render json: { error: 'No autenticado' }, status: :unauthorized
        end
      end

      private

      def set_profile
        @profile = Profile.find(params[:id])
      end

      def profile_params
        params.require(:profile).permit(:full_name, :email, :phone, :address, :city, :state, :postal_code, :password)
      end
    end
  end
end
