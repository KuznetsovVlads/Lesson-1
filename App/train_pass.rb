# Класс для создания пассажирских поездов
# Имеет родительский класс Train
class TrainPass < Train
  attr_reader :type, :route

  def initialize(number)
    super
    @type = :pass
  end
end
