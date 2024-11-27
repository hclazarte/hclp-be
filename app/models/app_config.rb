class AppConfig
  @instance = nil

  private_class_method :new

  # Método para obtener la única instancia
  def self.instance
    @instance ||= new
  end

  # Configuraciones iniciales
  def initialize
    @settings = {
      database: "ecommerce_db",
      ui_theme: "light",
      cache_enabled: true
    }
  end

  # Método para obtener configuraciones
  def get(key)
    @settings[key]
  end

  # Método para establecer configuraciones
  def set(key, value)
    @settings[key] = value
  end
end
