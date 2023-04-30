# Класс для создания грузовых поездов
# Имеет родительский класс Train
class TrainCargo < Train
  attr_reader :type, :route

  def initialize(number)
    super
    @type = :cargo
  end
end
