class PhysicalProduct < Product
  # Validaciones específicas para productos físicos
  validates :weight, :dimensions, presence: true

  # Método específico para productos físicos
  def display_details
    "Name: #{name}, Price: #{price}, Weight: #{weight}kg, Dimensions: #{dimensions}"
  end
end

