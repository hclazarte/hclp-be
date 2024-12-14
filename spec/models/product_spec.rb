RSpec.describe Product, type: :model do
  let(:product) { Product.new(name: "Products Test", stock: 10, price: 20.0) }

  it "es válido con todos los atributos requeridos" do
    expect(product).to be_valid
  end

  it "no es válido sin un nombre" do
    product.name = nil
    expect(product).not_to be_valid
  end

  it "no permite precios negativos" do
    product.price = -10
    expect(product).not_to be_valid
  end

  it "no permite stock negativo" do
    product.stock = -5
    expect(product).not_to be_valid
  end
end
