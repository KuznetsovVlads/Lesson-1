class Train
  attr_reader :amount_wagons, :current_station, :number, :type
  attr_accessor :speed # можем устанавливать и получать скорость поезда

  def initialize(number, type, amount_wagons)
    @number = number
    @type = type
    @amount_wagons = amount_wagons
    @speed = 0
    @route = nil
    @current_station = nil
  end

  # поезд может тормозить
  def stop_train
    @speed = 0
  end

  # поезд может прицеплять вагоны
  def add_wagon
    @amount_wagons += 1 if @speed.zero?
  end

  # поезд может отцеплять вагоны
  def remove_wagon
    @amount_wagons -= 1 if @amount_wagons > 0 && @speed.zero?
  end

  # поезд может принимать маршрут следования
  def assign_route(route)
    @route = route
    @current_station = @route.list_stations[0]
    @current_station.add_train(self)
  end

  # пщезд может перемещаться между станциями
  def go_to_next_station
    if index_current_station == @route.list_stations.size - 1
      puts 'Вы уже на конечной станции'
    else
      remove_train_from_station
      @current_station = @route.list_stations[index_current_station + 1] # Переходим на следующую станцию
      add_train_on_new_station # Ставим поезд на новую станцию
    end
  end

  def go_to_previos_station
    if index_current_station.zero?
      puts 'Вы на первой станции'
    else
      remove_train_from_station
      @current_station = @route.list_stations[index_current_station - 1]
      add_train_on_new_station # Ставим поезд на новую станцию
    end
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
