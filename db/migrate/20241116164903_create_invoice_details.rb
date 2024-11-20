class CreateInvoiceDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :invoice_details do |t|
      t.references :electronic_invoice, null: false, foreign_key: true
      t.string :actividad_economica, null: false
      t.string :codigo_producto_sin, null: false
      t.string :codigo_producto, null: false
      t.string :descripcion, null: false
      t.decimal :cantidad, precision: 10, scale: 5, null: false
      t.integer :unidad_medida, null: false
      t.decimal :precio_unitario, precision: 15, scale: 5, null: false
      t.decimal :monto_descuento, precision: 15, scale: 2
      t.decimal :sub_total, precision: 15, scale: 2, null: false

      t.timestamps
    end
  end
end
