# Класс для создания обьектов типа поезд.
class Train
  attr_reader :wagons, :current_station, :number, :type, :route

  attr_accessor :speed # можем устанавливать и получать скорость поезда

  def initialize(number)
    @number = number
    @type = nil
    @wagons = []
    @speed = 0
    @route = nil
    @current_station = nil
  end

  # поезд может тормозить
  def stop_train
    @speed = 0
  end

  # поезд может прицеплять вагоны
  def add_wagon(wagon_name)
    wagons << wagon_name if @type == wagon_name.type && @speed.zero?
  end

  # поезд может отцеплять вагоны
  def remove_wagon
    wagons.pop if @speed.zero?
  end

  # поезд может принимать маршрут следования
  def assign_route(route)
    @route = route
    @current_station = @route.list_stations[0]
    @current_station.add_train(self)
  end

  # поезд может перемещаться между станциями
  def go_to_next_station
    remove_train_from_station
    @current_station = @route.list_stations[index_current_station + 1] # Переходим на следующую станцию
    add_train_on_new_station # Ставим поезд на новую станцию
  end

  def go_to_previous_station
    remove_train_from_station
    @current_station = @route.list_stations[index_current_station - 1]
    add_train_on_new_station # Ставим поезд на новую станцию
  end

  # поезд  может возвращать предыдущую станцию на основе маршрута
  def previous_station
    @route.list_stations[index_current_station - 1] if index_current_station >= 1
  end

  # поезд  может возвращать следующую станцию на основе маршрута
  def next_station
    @route.list_stations[index_current_station + 1] if index_current_station < (@route.list_stations.size - 1)
  end

  private

  # метод для уменьшения дублирования в коде
  def index_current_station
    @route.list_stations.index(@current_station)
  end

  # удаляем поезд со станции
  def remove_train_from_station
    @current_station.send_train(self)
  end

  # Ставим поезд на новую станцию
  def add_train_on_new_station
    @current_station.add_train(self)
  end
end
