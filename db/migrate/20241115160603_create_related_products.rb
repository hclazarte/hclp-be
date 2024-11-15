class CreateRelatedProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :related_products do |t|
      t.string :relationship_type
      t.integer :product_id
      t.integer :related_product_id
      t.timestamps
    end
  end
end
