class CreateInvoices < ActiveRecord::Migration[7.0]
  def change
    create_table :invoices do |t|
      t.string :nit_emisor
      t.string :razon_social_emisor
      t.string :municipio
      t.string :telefono
      t.string :numero_factura
      t.string :cuf
      t.string :cufd
      t.integer :codigo_sucursal
      t.string :direccion
      t.integer :codigo_punto_venta
      t.datetime :fecha_emision
      t.string :nombre_razon_social
      t.integer :codigo_tipo_documento_identidad
      t.string :numero_documento
      t.string :complemento
      t.string :codigo_cliente
      t.integer :codigo_metodo_pago
      t.string :numero_tarjeta
      t.decimal :monto_total, precision: 15, scale: 2
      t.decimal :monto_total_sujeto_iva, precision: 15, scale: 2
      t.integer :codigo_moneda
      t.decimal :tipo_cambio, precision: 10, scale: 5
      t.decimal :monto_total_moneda, precision: 15, scale: 2
      t.decimal :monto_gift_card, precision: 15, scale: 2
      t.decimal :descuento_adicional, precision: 15, scale: 2
      t.integer :codigo_excepcion
      t.string :cafc
      t.string :leyenda
      t.string :usuario
      t.integer :codigo_documento_sector
      t.timestamps
    end
  end
end
