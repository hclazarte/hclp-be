class Api::V1::InvoicesController < ApplicationController
  def create
    ActiveRecord::Base.transaction do
      order = Order.find(params[:order_id])

      # Actualizar el estado de la orden a "completed"
      order.update!(status: 'completed')

      # Crear la cabecera de la factura usando datos de configuración y parámetros del usuario
      invoice = Invoice.create!(
        order_id: order.id,
        nit_emisor: Rails.application.config.invoice_defaults[:nit_emisor],
        razon_social_emisor: Rails.application.config.invoice_defaults[:razon_social_emisor],
        municipio: Rails.application.config.invoice_defaults[:municipio],
        telefono: Rails.application.config.invoice_defaults[:telefono],
        numero_factura: SecureRandom.uuid, # Generar un número único
        cuf: SecureRandom.hex(16),         # Generar CUF único
        cufd: SecureRandom.hex(16),        # Generar CUFD único
        codigo_sucursal: Rails.application.config.invoice_defaults[:codigo_sucursal],
        direccion: Rails.application.config.invoice_defaults[:direccion],
        codigo_punto_venta: Rails.application.config.invoice_defaults[:codigo_punto_venta],
        fecha_emision: Time.zone.now,
        nombre_razon_social: params[:nombre_razon_social],
        codigo_tipo_documento_identidad: params[:codigo_tipo_documento_identidad],
        numero_documento: params[:numero_documento],
        complemento: params[:complemento],
        codigo_cliente: params[:codigo_cliente]
      )

      # Agregar detalles de la factura
      order.order_items.each do |item|
        InvoiceDetail.create!(
          invoice_id: invoice.id,
          actividad_economica: '610000', # Valor predeterminado
          codigo_producto_sin: item.product.category, # Asumiendo que `category` se mapea con `codigo_producto_sin`
          codigo_producto: item.product.id,
          descripcion: item.product.name,
          cantidad: item.quantity,
          unidad_medida: 58, # Asumiendo una unidad predeterminada
          precio_unitario: item.product.price,
          monto_descuento: 0, # Predeterminado
          sub_total: item.quantity * item.product.price
        )
      end

      render json: { message: 'Invoice created successfully', invoice: invoice }, status: :created
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def index
    invoices = Invoice.all
    render json: invoices, status: :ok
  end

  def show
    invoice = Invoice.find(params[:id])
    render json: invoice, include: :invoice_details, status: :ok
  end
end
