class PhysicalProduct < Product
  validates :weight, :dimensions, presence: true
end
