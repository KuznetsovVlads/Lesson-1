# Класс для создания пассажирских поездов
# Имеет родительский класс Train
class TrainPass < Train

  def add_wagon(wagon)
    super

    @wagons << wagon if wagon.is_a?(WagonPass)
  end
end
