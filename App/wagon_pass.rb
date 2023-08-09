# frozen_string_literal: true

# Class for creating cars of exclusively passenger type
require_relative 'manufacturer'
require_relative 'validation'

# Класс для создания вагонов исключительно пассажирского типа
class WagonPass
  include Manufacturer
  include Validation::ValidWagonPass
  attr_reader :occupied_seats

  def initialize(total_seats)
    @total_seats = total_seats
    @occupied_seats ||= 0
    validate!
  end

  # метод, который "занимает места" в вагоне (по одному за раз)
  def occupy_seat
    @occupied_seats += 1 if @occupied_seats < @total_seats
  end

  # метод, возвращающий кол-во свободных мест в вагоне
  def empty_seats
    @total_seats - @occupied_seats
  end
end
