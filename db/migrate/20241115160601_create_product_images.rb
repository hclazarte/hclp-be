class CreateProductImages < ActiveRecord::Migration[7.0]
  def change
    create_table :product_images do |t|
      t.integer :product_id
      t.string :image_url
      t.timestamps
    end
  end
end
