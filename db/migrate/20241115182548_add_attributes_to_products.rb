class AddAttributesToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :file_format, :string
    add_column :products, :file_size, :integer
    add_column :products, :weight, :decimal, precision: 10, scale: 2
    add_column :products, :dimensions, :string
  end
end
