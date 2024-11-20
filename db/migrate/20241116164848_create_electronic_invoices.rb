class CreateElectronicInvoices < ActiveRecord::Migration[6.1]
  def change
    create_table :electronic_invoices do |t|
      t.integer :codigo_sucursal, null: false
      t.string :cuf, null: false
      t.string :cufd, null: false
      t.datetime :fecha_emision, null: false
      t.string :codigo_cliente, null: false, index: true
      t.references :order, null: false, foreign_key: true
      t.integer :codigo_metodo_pago, null: false
      t.decimal :monto_total, precision: 15, scale: 2, null: false
      t.decimal :monto_total_sujeto_iva, precision: 15, scale: 2, null: false
      t.integer :codigo_moneda, null: false
      t.decimal :tipo_cambio, precision: 10, scale: 5, null: false
      t.decimal :monto_total_moneda, precision: 15, scale: 2, null: false
      t.decimal :monto_gift_card, precision: 15, scale: 2, default: 0
      t.decimal :descuento_adicional, precision: 15, scale: 2, default: 0
      t.integer :codigo_excepcion, null: false
      t.string :leyenda, null: false
      t.string :usuario, null: false
      t.integer :codigo_documento_sector, null: false

      t.timestamps
    end
  end
end
