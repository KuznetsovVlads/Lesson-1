# Класс для создания обьектов типа поезд.
require_relative './manufacturer'
require_relative './instance_counter'
require_relative './toall'

class Train
  include InstanceCounter
  include Manufacturer
  include ToAll

  attr_reader :wagons, :current_station, :number, :route

  attr_accessor :speed # можем устанавливать и получать скорость поезда

  def initialize(number)
    @number = number
    @wagons = []
    @speed = 0
    @route = nil
    @current_station = nil
    add_self_to_all
    register_instance
  end

  # find - метод класса, принимает номер поезда (указанный при его создании)
  # и возвращает объект поезда по номеру или nil,
  # если поезд с таким номером не найден.
  def self.find(number)
    @all_trains.find { |train| train.number == number }
  end

  def self.all
    @all_trains ||= []
  end

  # поезд может тормозить
  def stop_train
    @speed = 0
  end

  def add_wagon(wagon)
    return unless @speed.zero?
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
    return if @current_station == @route.list_stations.last

    remove_train_from_station
    @current_station = @route.list_stations[index_current_station + 1]
    add_train_on_new_station
  end

  def go_to_previous_station
    return if @current_station == @route.list_stations.first

    remove_train_from_station
    @current_station = @route.list_stations[index_current_station - 1]
    add_train_on_new_station
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
