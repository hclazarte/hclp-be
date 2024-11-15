class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.integer :order_id
      t.string :method
      t.string :status
      t.string :transaction_id
      t.decimal :amount, precision: 10, scale: 2
      t.text :details
      t.timestamps
    end
  end
end
