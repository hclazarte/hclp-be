class DigitalProduct < Product
  # Validaciones específicas para productos digitales
  validates :file_format, :file_size, presence: true

  # Método específico para productos digitales
  def display_details
    "Name: #{name}, Price: #{price}, File Format: #{file_format}, File Size: #{file_size}MB"
  end
end
