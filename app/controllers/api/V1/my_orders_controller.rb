module Api
  module V1
    class MyOrdersController < ActionController::API
      before_action :doorkeeper_authorize!

      def index
        orders = current_resource_owner.orders
        render json: orders, include: :order_items
      end

      def create
        @order = current_resource_owner.orders.new(order_params)

        if @order.save
          render json: @order, status: :created
        else
          render json: @order.errors, status: :unprocessable_entity
        end
      end      

      private

      def current_resource_owner
        @current_resource_owner ||= Profile.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
      end

      def order_params
        # Permitir parámetros para crear una orden y sus ítems asociados
        params.require(:order).permit(:status, :total, :date, order_items_attributes: [:product_id, :quantity, :price])
      end
    end
  end
end
