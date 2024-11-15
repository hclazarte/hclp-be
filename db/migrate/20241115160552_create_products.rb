class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.decimal :price, precision: 10, scale: 2
      t.integer :stock
      t.string :category
      t.string :image_url
      t.integer :parent_product_id
      t.timestamps
    end
  end
end
