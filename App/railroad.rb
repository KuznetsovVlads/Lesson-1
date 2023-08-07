# frozen_string_literal: true

# Класс который позволяет через текстовый интерфейс делать следующее:
#  - Создавать станции
#  - Создавать поезда
#  - Создавать маршруты и управлять станциями в нем (добавлять, удалять)
#  - Назначать маршрут поезду
#  - Добавлять вагоны к поезду
#  - Отцеплять вагоны от поезда
#  - Перемещать поезд по маршруту вперед и назад
#  - Просматривать список станций и список поездов на станции

require_relative './route'
require_relative './station'
require_relative './train'
require_relative './train_cargo'
require_relative './train_pass'
require_relative './wagon_cargo'
require_relative './wagon_pass'
require_relative './validation'

class RailRoad
  include Validation::ValidTrain

  attr_reader :stations, :routes, :trains, :wagons

  def initialize
    @stations = []
    @routes = []
    @trains = []
    @wagons = []
  end

  def menu
    clear
    show_menu
    answer = gets.to_i
    clear
    case answer
    when 1
      create
    when 2
      operation
    when 3
      info
    else
      puts 'Выход'
    end
  end

  def create
    show_menu_create
    answer = gets.to_i
    clear
    case answer
    when 1
      create_station
    when 2
      create_train
    when 3
      create_wagon
    when 4
      create_route
    else
      menu
    end
    return_to_menu
  end

  def create_station
    puts 'Ведите название станции которую хотите создать'
    name_station = gets.chomp.strip
    @stations << Station.new(name_station)
    puts "Станция #{name_station} успешно создана"
  rescue RuntimeError => e
    puts_error(e)
  end

  def create_train
    show_menu_create_train
    answer = gets.to_i
    clear
    case answer
    when 1
      @trains << TrainCargo.new(check_correct_number_train)
      puts 'Грузовой поезд успешно создан'
    when 2
      @trains << TrainPass.new(check_correct_number_train)
      puts 'Пассажирский поезд успешно создан'
    else
      create
    end
  rescue RuntimeError => e
    puts e
    puts 'Повторите попытку'
    sleep 2
    clear
    create_train
  end

  def create_wagon
    show_menu_create_wagon
    answer = gets.to_i
    clear
    case answer
    when 1
      puts 'Укажите объем вагона в тоннах (от 60 до 250)'
      volume = gets.to_i
      @wagons << WagonCargo.new(volume)
      puts "Создан один грузовой вагон вмещяющий #{volume} тонн"
    when 2
      puts 'Укажите количество мест в вагоне (от 10 до 100)'
      seats = gets.to_i
      @wagons << WagonPass.new(seats)
      puts "Создан один пассажирский вагон на #{seats} мест"
    else
      create
    end
  rescue RuntimeError => e
    puts_error(e)
  end

  def create_route
    info_stations
    raise 'Недостаточно станций для создания маршрута' if stations.size < 2

    puts 'Ведите название начальной станции маршрута'
    start_station_name = gets.chomp
    puts 'Ведите название конечной станции маршрута'
    end_station_name = gets.chomp
    start_station = stations.find { |station| station.name == start_station_name }
    end_station = stations.find { |station| station.name == end_station_name }
    @routes << Route.new(start_station, end_station)
    puts "Маршрут: #{start_station_name} - #{end_station_name} успешно создан"
  rescue RuntimeError => e
    puts_error(e)
  end

  def operation
    show_menu_operation
    answer = gets.to_i
    clear
    case answer
    when 1
      raise 'Маршрутов не существует' if routes.empty?
      raise 'Недостаточное количество станций' if stations.size < 3

      operation_with_station
    when 2
      raise 'Маршрутов не существует' if @routes.empty?
      raise 'Поездов не существует' if @trains.empty?

      add_route_to_train

    when 3
      raise 'Не найдено ни одного поезда' if @trains.empty?

      operation_with_wagon
    when 4
      raise 'Не найдено ни одного поезда' if trains.empty?

      operation_with_train
    else
      menu
    end
    return_to_menu
  rescue RuntimeError => e
    puts_error(e)
  end

  def operation_with_station
    show_menu_operation_with_station
    answer = gets.to_i
    clear
    route = which_route
    raise 'Маршрут не найден' if route.nil?

    puts 'В этом маршруте есть следующие станции:'
    route.info
    station = which_station
    raise 'Станция не найдена' if station.nil?

    case answer
    when 1
      add_station_to_route(route, station)
    when 2
      remove_station_from_route(route, station)
    else
      operation
    end
  rescue RuntimeError => e
    puts_error(e)
  end

  def add_station_to_route(route, station)
    raise 'Станция уже есть в списке остановок' if route.list_stations.include?(station)

    route.add_station(station)
    puts 'Станция добавлена в список остановок'
  rescue RuntimeError => e
    puts_error(e)
  end

  def remove_station_from_route(route, station)
    raise 'Невозможно удалить эту станцию' if station == route.list_stations[0] || station == route.list_stations[-1]
    raise 'Этой станции нет в маршруте' unless route.list_stations.include?(station)

    route.delete_station(station)
    puts 'Станция удалена из маршрута'
  rescue RuntimeError => e
    puts_error(e)
  end

  def add_route_to_train
    route = which_route
    raise 'Маршрут не найден' if route.nil?

    train = which_train
    raise 'Поезд не найден' if train.nil?

    train.assign_route(route)
    puts "Поезду № #{train.number} назначен маршрут: "
    route.info
  rescue RuntimeError => e
    puts_error(e)
  end

  def operation_with_wagon
    show_operation_with_wagon
    answer = gets.to_i
    clear
    return if answer.zero?

    train = which_train
    raise 'Такого поезда не существует' if train.nil?
    raise 'Поезд находится в движении' unless train.speed.zero?

    case answer
    when 1
      add_wagon_to_train(train)
    when 2
      raise 'У поезда не найдено ни одного вагона' if train.wagons.empty?

      remove_wagon_from_train(train)
    when 3
      raise 'У поезда не найдено ни одного вагона' if train.wagons.empty?

      occupy_wagon(train)
    else
      menu
    end
  rescue RuntimeError => e
    puts_error(e)
  end

  def add_wagon_to_train(train)
    wagon = find_wagon_by_type(train)
    raise 'Не найдено свободных вагонов такого типа' if wagon.nil?

    train.add_wagon(wagon)
    @wagons.delete(wagon)
    puts 'Вагон успешно прицеплен к поезду'
  rescue RuntimeError => e
    puts_error(e)
  end

  def remove_wagon_from_train(train)
    raise 'У этого поезда нет вагонов' if train.wagons.empty?

    wagon = train.wagons.last
    train.remove_wagon
    wagons << wagon
    puts 'Вагон успешно отцеплен от поезда'
  rescue RuntimeError => e
    puts_error(e)
  end

  def occupy_wagon(train)
    current_wagon = which_wagon(train)
    raise 'Вагон не найден' if current_wagon.nil?

    if current_wagon.is_a?(WagonCargo)
      raise 'Вагон полный' if current_wagon.empty_volume.zero?

      puts "Свободного объема: #{current_wagon.empty_volume}"
      puts 'Какой объем хотите загрузить?'
      volume_cargo = gets.to_f
      raise 'неправильное значение' if volume_cargo > current_wagon.empty_volume || volume_cargo.zero?

      current_wagon.occupy_volume(volume_cargo)
      puts 'вагон успешно загружен'
    elsif current_wagon.is_a?(WagonPass)
      raise 'В вагоне нет больше мест' if current_wagon.empty_seats.zero?

      current_wagon.occupy_seat
      puts 'Успешно занято 1 место'
      puts "Осталось свободных мест: #{current_wagon.empty_seats}"
    end
  rescue RuntimeError => e
    puts_error(e)
  end

  def operation_with_train
    train = which_train
    raise 'Такого поезда не существует' if train.nil?
    raise 'У поезда не задан маршрут' if train.current_station.nil?

    show_operation_with_train
    answer = gets.to_i
    clear
    case answer
    when 1
      move_train_forvard(train)
    when 2
      move_train_back(train)
    else
      menu
    end
  rescue RuntimeError => e
    puts_error(e)
  end

  def move_train_forvard(train)
    raise 'Вы уже на конечной станции' if train.current_station == train.route.list_stations.last

    train.go_to_next_station
    puts "Поезд № #{train.number} перемещен на следующую станцию: #{train.current_station.name}"
  rescue RuntimeError => e
    puts_error(e)
  end

  def move_train_back(train)
    raise 'Вы на первой станции' if train.current_station == train.route.list_stations.first

    train.go_to_previous_station
    puts "Поезд № #{train.number} перемещен на предыдущую станцию: #{train.current_station.name}"
  rescue RuntimeError => e
    puts_error(e)
  end

  def info
    show_info
    answer = gets.to_i
    clear
    case answer
    when 1
      info_stations
    when 2
      info_trains_on_station
    when 3
      raise 'Поездов не существует' if trains.empty?

      train = which_train
      info_wagons_of_train(train)
    when 4
      info_instances
    else
      menu
    end
    return_to_menu
  rescue RuntimeError => e
    puts_error(e)
  end

  def info_stations
    raise 'Станций не существует' if stations.empty?

    puts "Существуют такие станции: #{stations.map(&:name).join(', ')}"
  end

  def info_trains_on_station
    raise 'Поездов не существует' if trains.empty?

    station = which_station
    raise 'Нет такой станции' if station.nil?
    raise 'На станции нет поездов' if station.trains.empty?

    station.each_trains do |train|
      puts [train.number,
            train.is_a?(TrainPass) ? 'Пассажирский' : 'Грузовой',
            "#{train.wagons.size} вагонов"].join(', ')
    end
    sleep 3
  rescue RuntimeError => e
    puts_error(e)
  end

  def info_wagons_of_train(train)
    raise 'Нет такого поезда' if train.nil?
    raise 'У это поезда нет ни одного вагона' if train.wagons.empty?

    train.each_wagons do |wagon, i|
      if train.is_a?(TrainCargo)
        puts ["вагон №#{i + 1}",
              'грузовой',
              "#{wagon.empty_volume}т. свободного места",
              "#{wagon.occupied_volume}т. загружено"].join(', ')
      elsif train.is_a?(TrainPass)
        puts ["вагон №#{i + 1}",
              'пассажирский',
              "#{wagon.empty_seats} свободных мест",
              "#{wagon.occupied_seats} занятых мест"].join(', ')
      end
    end
    sleep 3
  rescue RuntimeError => e
    puts_error(e)
  end

  def info_instances
    puts "Station instances = #{Station.instances}"
    puts "Train Cargo instances = #{TrainCargo.instances}"
    puts "Train Pass instances = #{TrainPass.instances}"
  end

  private

  # методы для показа текста для пользователя
  def show_menu
    puts ['Введите 1, если вы хотите создать станцию, поезд, вагон или маршрут',
          'Введите 2, если вы хотите произвести операцию с созданными объектами',
          'Введите 3, если вы хотите вывести текущие данные о объектах',
          'Введите 0 или стоп если хотите закончить программу'].join("\n")
  end

  def show_menu_create
    puts ['Введите 1, если вы хотите создать станцию',
          'Введите 2, если вы хотите создать поезд',
          'Введите 3, если вы хотите создать вагон',
          'Введите 4, если вы хотите создать маршрут',
          'Введите 0, если вы хотите вернуться в предыдущее меню'].join("\n")
  end

  def show_menu_create_train
    puts ['Введите 1, если хотите создать грузовой поезд',
          'Введите 2, если хотите создать пассажирский поезд',
          'Введите 0, если хотите вернуться в предыдущее меню'].join("\n")
  end

  def show_menu_create_wagon
    puts ['Ведите 1, если хотите создать грузовой вагон',
          'Ведите 2, если хотите создать пассажирский вагон',
          'Введите 0, если хотите вернуться в предыдущее меню'].join("\n")
  end

  def show_menu_operation
    puts ['Введите 1, если вы хотите добавить или удалить станцию в маршруте',
          'Введите 2, если вы хотите назначить маршрут поезду',
          'Введите 3, если вы хотите произвести действие с вагонами',
          'Введите 4, если вы хотите перемещать поезд по маршруту вперед и назад',
          'Введите 0, если хотите вернуться в предыдущее меню'].join("\n")
  end

  def show_menu_operation_with_station
    puts ['Введите 1, если вы хотите добавить станцию в маршруте',
          'Введите 2, если вы хотите удалить станцию в маршруте',
          'Введите 0, если хотите вернуться в предыдущее меню'].join("\n")
  end

  def show_operation_with_wagon
    puts ['Введите 1, если вы хотите добавить вагон',
          'Введите 2, если вы хотите удалить вагон',
          'Введите 3, если вы хотите загрузить вагон',
          'Введите 0, если хотите вернуться в предыдущее меню'].join("\n")
  end

  def show_operation_with_train
    puts ['Введите 1, если вы хотите переместить поезд вперед',
          'Введите 2, если вы хотите переместить поезд назад',
          'Введите 0, если хотите вернуться в предыдущее меню'].join("\n")
  end

  def show_info
    puts ['Введите 1, если вы хотите посмотреть список станций',
          'Введите 2, если вы хотите посмотреть список поездов на станции',
          'Введите 3, если вы хотите посмотреть список вагонов у поезда',
          'Введите 4, если вы хотите посмотреть количество созданных объектов',
          'Введите 0, если хотите вернуться в предыдущее меню'].join("\n")
  end
  # очищаем экран
  def clear
    system('clear') || system('cls')
  end

  # сообщение и запуск главного меню
  def return_to_menu
    puts 'Возврат в меню через 3 секунды'
    sleep 3
    menu
  end

  # Доп метод для проверки данных для создания поезда
  def check_correct_number_train
    puts 'Ведите номер поезда который хотите создать в формате ***-**'
    number = gets.chomp.strip
    raise 'Поезд с таким номером уже существует' if @trains.find { |train| train.number == number }

    number
  rescue RuntimeError => e
    puts_error(e)
  end

  # доп метод для выбора маршрута
  def which_route
    puts 'Введите номер необходимого маршрута'
    @routes.each.with_index(1) do |route, index|
      puts "Маршрут #{index}: #{route.list_stations[0].name} - #{route.list_stations[-1].name}"
    end
    answer = gets.to_i
    @routes[answer - 1]
  end

  # доп метод для выбора станции
  def which_station
    info_stations
    puts 'Введите название станции'
    station_name = gets.chomp
    @stations.find { |station| station.name == station_name }
  end

  # доп метод для выбора поезда
  def which_train
    puts "Существуют следующие поезда: #{trains.map(&:number).join(', ')}"
    puts 'Введите номер поезда'
    num_trains = gets.chomp
    @trains.find { |train| train.number == num_trains }
  end

  # доп метод для выбора вагона
  def which_wagon(train)
    info_wagons_of_train(train)
    puts 'Введите номер вагона для действия'
    num_wagon = gets.to_i
    train.wagons[num_wagon - 1]
  end

  # метод для поиска соответствующего вагона типу поезда
  def find_wagon_by_type(train)
    if train.is_a? TrainCargo
      @wagons.find { |wagon| wagon.is_a? WagonCargo }
    elsif train.is_a? TrainPass
      @wagons.find { |wagon| wagon.is_a? WagonPass }
    end
  end

  def puts_error(e)
    puts 'Ошибка!'
    puts e
    return_to_menu
  end
end
