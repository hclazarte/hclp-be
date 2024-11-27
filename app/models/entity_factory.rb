class EntityFactory
  def self.create_entity(type, attributes = {})
    case type.to_sym
    when :digital_product
      DigitalProduct.new(attributes)
    when :physical_product
      PhysicalProduct.new(attributes)
    when :customer
      Profile.new(attributes.merge(user_role: "customer"))
    when :admin
      Profile.new(attributes.merge(user_role: "admin"))
    else
      raise "Unknown entity type: #{type}"
    end
  end
end
