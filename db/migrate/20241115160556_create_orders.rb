class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.integer :profile_id
      t.string :status
      t.decimal :total
      t.datetime :date
      t.timestamps
    end
  end
end
