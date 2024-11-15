class CreateShipments < ActiveRecord::Migration[7.0]
  def change
    create_table :shipments do |t|
      t.integer :order_id
      t.text :address
      t.string :city
      t.string :state
      t.string :postal_code
      t.string :method
      t.string :status
      t.decimal :cost, precision: 10, scale: 2
      t.string :tracking_number
      t.timestamps
    end
  end
end
