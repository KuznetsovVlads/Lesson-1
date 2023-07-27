# Класс для создания вагонов исключительно пассажирского типа
require_relative './manufacturer'
require_relative './validation'

class WagonPass
  include Manufacturer
  include Validation::ValidWagonPass
  attr_reader :occupied_seats

  def initialize(total_seats)
    @total_seats = total_seats
    @occupied_seats = 0
    validate!
  end

  def occupy_seat
    # метод, который "занимает места" в вагоне (по одному за раз)
    @occupied_seats += 1 if @occupied_seats < @total_seats
  end

  def empty_seats
    # метод, возвращающий кол-во свободных мест в вагоне
    @total_seats - @occupied_seats
  end
end
