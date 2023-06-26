require_relative './instance_counter'
require_relative './toall'

class Station
  include InstanceCounter
  include ToAll
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
    register_instance
    add_self_to_all
  end

  # принимаем поезда (по одному за раз)
  def add_train(train)
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
