class CreateOrderItems < ActiveRecord::Migration[7.0]
  def change
    create_table :order_items do |t|
      t.integer :order_id
      t.integer :product_id
      t.integer :quantity
      t.decimal :price
      t.decimal :discount, precision: 5, scale: 2
      t.timestamps
    end
  end
end
