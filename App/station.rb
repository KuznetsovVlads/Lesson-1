# Класс для создания станций
require_relative './instance_counter'
require_relative './toall'
require_relative './validation'

class Station
  include InstanceCounter
  include ToAll
  include Validation::ValidStation
  include Validation

  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
    add_self_to_all
    validate!
    register_instance
  end

  # принимаем поезда (по одному за раз)
  def add_train(train)
    raise 'Ошибка данных' if train.is_a(TrainCargo) || train.is_a(TrainPass)

    @trains << train
  end

  # возвращаем список поездов на станции по типу: кол-во грузовых, пассажирских
  def trains_by_type(type)
    trains_list = []
    @trains.each do |train|
      trains_list << train if train.type == type
    end
    trains_list
  end

  # отправляем поезда
  def send_train(train)
    @trains.delete(train)
  end

end
