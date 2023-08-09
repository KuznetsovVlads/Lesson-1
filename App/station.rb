# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'toall'
require_relative 'validation'

# Класс для создания станций
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
    raise 'Ошибка данных' unless train.is_a?(TrainCargo) || train.is_a?(TrainPass)

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

  # метод, который принимает блок и проходит по всем поездам на станции, передавая каждый поезд в блок
  def each_trains(&block)
    puts "На станции - #{@name} находятся следующие поезда:"
    @trains.each(&block)
  end
end
