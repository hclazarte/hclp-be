class DropElectronicInvoices < ActiveRecord::Migration[7.0]
  def change
    drop_table :electronic_invoices do |t|
      t.integer :codigo_sucursal
      t.string :cuf
      t.string :cufd
      t.datetime :fecha_emision
      t.string :codigo_cliente
      t.integer :order_id
      t.integer :codigo_metodo_pago
      t.decimal :monto_total, precision: 15, scale: 2
      t.decimal :monto_total_sujeto_iva, precision: 15, scale: 2
      t.integer :codigo_moneda
      t.decimal :tipo_cambio, precision: 10, scale: 5
      t.decimal :monto_total_moneda, precision: 15, scale: 2
      t.decimal :monto_gift_card, precision: 15, scale: 2, default: "0.0"
      t.decimal :descuento_adicional, precision: 15, scale: 2, default: "0.0"
      t.integer :codigo_excepcion
      t.string :leyenda
      t.string :usuario
      t.integer :codigo_documento_sector
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
    end
  end
end
