class AddAttributesToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :file_format, :string
    add_column :products, :file_size, :integer
    add_column :products, :weight, :decimal
    add_column :products, :dimensions, :string
  end
end
