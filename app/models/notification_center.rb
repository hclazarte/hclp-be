class NotificationCenter
  def initialize
    @observers = {}
  end

  # Suscribir a un evento
  def subscribe(event_name, observer)
    @observers[event_name] ||= []
    @observers[event_name] << observer
  end

  # Notificar a los observadores
  def notify(event_name, data = nil)
    return unless @observers[event_name]

    @observers[event_name].each do |observer|
      observer.update(event_name, data)
    end
  end
end

# Ejemplo de un observador
class InventoryObserver
  def update(event_name, data)
    puts "Inventory updated for event: #{event_name}, data: #{data}"
  end
end

class OrderObserver
  def update(event_name, data)
    puts "Order status changed for event: #{event_name}, data: #{data}"
  end
end
