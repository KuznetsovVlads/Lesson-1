# Класс для создания вагонов исключительно грузового типа
class WagonCargo < Wagon
  attr_reader :type

  def initialize
    super
    @type = :cargo
  end
end
