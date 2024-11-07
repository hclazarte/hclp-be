class PhysicalProduct < Product
  validates :weight, :dimensions, presence: true

  def display_details
    "Name: #{name}, Price: #{price}, Weight: #{weight}kg, Dimensions: #{dimensions}"
  end
end
