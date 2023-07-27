# Класс для создания грузовых поездов
# Имеет родительский класс Train
class TrainCargo < Train

  def add_wagon(wagon)
    super

    @wagons << wagon if wagon.is_a?(WagonCargo)
  end
end
