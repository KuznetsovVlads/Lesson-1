# Класс для создания вагонов исключительно пассажирского типа
class WagonPass < Wagon
  attr_reader :type

  def initialize
    super
    @type = :pass
  end
end
