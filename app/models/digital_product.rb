class DigitalProduct < Product
  validates :file_format, :file_size, presence: true
end
