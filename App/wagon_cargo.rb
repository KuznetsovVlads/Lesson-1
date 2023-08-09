# frozen_string_literal: true

require_relative 'manufacturer'
require_relative 'validation'

# Класс для создания вагонов исключительно грузового типа
class WagonCargo
  include Manufacturer
  include Validation::ValidWagonCargo

  attr_reader :occupied_volume

  def initialize(total_volume)
    @total_volume = total_volume
    @occupied_volume ||= 0
    validate!
  end

  # метод, которые "занимает объем" в вагоне (объем указывается в качестве параметра метода)
  def occupy_volume(volume_cargo)
    @occupied_volume += volume_cargo.to_f if @occupied_volume < @total_volume
  end

  #  метод, который возвращает оставшийся (доступный) объем
  def empty_volume
    @total_volume - @occupied_volume
  end
end
