class DigitalProduct < Product
  validates :file_format, :file_size, presence: true

  def display_details
    "Name: #{name}, Price: #{price}, File Format: #{file_format}, File Size: #{file_size}MB"
  end
end
