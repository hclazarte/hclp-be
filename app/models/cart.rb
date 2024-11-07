class Cart < ApplicationRecord
  belongs_to :profile
  has_many :cart_items, dependent: :destroy

   # Método para agregar productos de diferentes maneras
   def add_product(product = nil, quantity: 1, id: nil, name: nil, price: nil)
    if id
      product = Product.find(id)
    elsif name && price
      product = Product.find_or_create_by(name: name, price: price)
    end

    if product
      cart_items.create(product: product, quantity: quantity)
    else
      raise ArgumentError, "Product not found or invalid parameters"
    end
  end
end
