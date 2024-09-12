module Api
  module V1
    class OrdersController < ApplicationController
      before_action :set_order, only: [:show, :update, :destroy]
      before_action :doorkeeper_authorize!
      before_action :set_profile, only: [:create]

      # GET /api/v1/orders
      # GET /api/v1/orders?profile_id=id
      def index
        if params[:profile_id]
          # Filtrar por profile_id si se pasa como parámetro
          @orders = Order.where(profile_id: params[:profile_id]).includes(:order_items)
        else
          # Devolver todas las órdenes con sus items
          @orders = Order.all.includes(:order_items)
        end

        # Serializar las órdenes junto con los items
        render json: @orders.to_json(include: :order_items)
      end

      # GET /api/v1/orders/:id
      def show
        order = Order.includes(:order_items).find(params[:id])
        if order
          render json: order, include: [:order_items]
        else
          render json: { error: 'Order not found' }, status: :not_found
        end
      end

      # POST /api/v1/orders
      def create
        @order = Order.new(order_params)
        if @order.save
          render json: @order, status: :created
        else
          render json: @order.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/orders/:id
      def update
        if @order.update(order_params)
          render json: @order
        else
          render json: @order.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/orders/:id
      def destroy
        @order.destroy
        head :no_content
      end

      private

      def set_order
        @order = Order.find(params[:id])
      end

      def set_profile
        @profile = Profile.find_by(id: params[:order][:profile_id])
        render json: { error: 'Profile not found' }, status: :not_found unless @profile
      end    

      def order_params
        params.require(:order).permit(:status, :total, :date, :profile_id, order_items_attributes: [:product_id, :quantity, :price])
      end
    end
  end
end
