class CreateReturnRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :return_requests do |t|
      t.integer :profile_id
      t.integer :order_id
      t.integer :product_id
      t.text :reason
      t.string :status
      t.datetime :requested_at
      t.timestamps
    end
  end
end
