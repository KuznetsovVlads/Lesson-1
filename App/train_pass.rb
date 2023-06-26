# Класс для создания пассажирских поездов
# Имеет родительский класс Train
class TrainPass < Train
  # def initialize(number)
  #   super(number)
  #   Train.all_trains << self
  # end

  def add_wagon(wagon)
    super

    @wagons << wagon if wagon.is_a?(WagonPass)
  end
end
