# Excepción para usuarios no autorizados
class UnauthorizedUserError < StandardError
  def initialize(message = "No tienes permiso para realizar esta acción.")
    super
  end
end
