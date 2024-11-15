class AddConstraints < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :cart_items, :carts
    add_foreign_key :cart_items, :products
    add_foreign_key :carts, :profiles
    add_foreign_key :notifications, :profiles
    add_foreign_key :orders, :profiles
    add_foreign_key :order_items, :orders
    add_foreign_key :order_items, :products
    add_foreign_key :payments, :orders
    add_foreign_key :shipments, :orders
    add_foreign_key :product_images, :products
    add_foreign_key :related_products, :products, column: :product_id
    add_foreign_key :related_products, :products, column: :related_product_id
    add_foreign_key :return_requests, :profiles
    add_foreign_key :return_requests, :orders
    add_foreign_key :return_requests, :products
  end
end
