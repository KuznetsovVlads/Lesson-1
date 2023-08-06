# frozen_string_literal: true

# Класс для создания маршрутов
require_relative './instance_counter'
require_relative './validation'

class Route
  include InstanceCounter
  include Validation::ValidRoute
  include Validation
  attr_reader :list_stations

  def initialize(start, finish)
    @list_stations = [start, finish]
    validate!
    register_instance
  end

  # добавляем промежуточную станцию в список
  def add_station(station)
    @list_stations.insert(-2, station) unless @list_stations.include?(station)
  end

  # удаляем промежуточную станцию из списка
  def delete_station(station)
    @list_stations.delete(station)
  end

  # выводим список всех станций по-порядку от начальной до конечной
  def info
    puts @list_stations.map(&:name).join(' -> ')
  end
end
