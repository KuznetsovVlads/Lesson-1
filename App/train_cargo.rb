# Класс для создания грузовых поездов
# Имеет родительский класс Train
class TrainCargo < Train
  def initialize(number)
    super(number)
    Train.all_trains << self
  end

  def add_wagon(wagon)
    super

    @wagons << wagon if wagon.is_a?(WagonCargo)
  end
end
