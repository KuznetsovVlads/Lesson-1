# Класс который позволяет через текстовый интерфейс делать следующее:
#  - Создавать станции
#  - Создавать поезда
#  - Создавать маршруты и управлять станциями в нем (добавлять, удалять)
#  - Назначать маршрут поезду
#  - Добавлять вагоны к поезду
#  - Отцеплять вагоны от поезда
#  - Перемещать поезд по маршруту вперед и назад
#  - Просматривать список станций и список поездов на станции
require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'train_cargo'
require_relative 'train_pass'
require_relative 'wagon_cargo'
require_relative 'wagon_pass'

class RailRoad
  attr_reader :stations, :routes, :trains, :wagons

  def initialize
    @stations = []
    @routes = []
    @trains = []
    @wagons = []
  end

  def menu
    clear
    puts ['Введите 1, если вы хотите создать станцию, поезд, вагон или маршрут',
          'Введите 2, если вы хотите произвести операцию с созданными объектами',
          'Введите 3, если вы хотите вывести текущие данные о объектах',
          'Введите 0 или стоп если хотите закончить программу'].join("\n")
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
      # exit
    end
  end

  def create
    puts ['Введите 1, если вы хотите создать станцию',
          'Введите 2, если вы хотите создать поезд',
          'Введите 3, если вы хотите создать вагон',
          'Введите 4, если вы хотите создать маршрут',
          'Введите 0, если вы хотите вернуться в предыдущее меню'].join("\n")
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
    if name_station.empty?
      puts 'Ошибка в названии станции'
    else
      @stations << Station.new(name_station)
      puts "Станция #{name_station} успешно создана"
    end
  end

  def create_train
    puts ['Введите 1, если хотите создать грузовой поезд',
          'Введите 2, если хотите создать пассажирский поезд',
          'Введите 0, если хотите вернуться в предыдущее меню'].join("\n")
    answer = gets.to_i
    clear
    number_train = check_correct_number_train
    if number_train.nil?
      puts 'Попробуйте снова'
    else
      case answer
      when 1
        @trains << TrainCargo.new(number_train)
        puts "Грузовой поезд №#{number_train} успешно создан"
      when 2
        @trains << TrainPass.new(number_train)
        puts "Пассажирский поезд №#{number_train} успешно создан"
      else
        create
      end
    end
  end

  def create_wagon
    puts ['Ведите 1, если хотите создать грузовой вагон',
          'Ведите 2, если хотите создать пассажирский вагон',
          'Введите 0, если хотите вернуться в предыдущее меню'].join("\n")
    answer = gets.to_i #answer_from_user
    clear
    case answer
    when 1
      @wagons << WagonCargo.new
      puts 'Создан один грузовой вагон'
    when 2
      @wagons << WagonPass.new
      puts 'Создан один пассажирский вагон'
    else
      create
    end
  end

  def create_route
    info_stations
    if stations.size < 2
      puts 'Недостаточно станций для создания'
    else
      puts 'Ведите название начальной станции маршрута'
      start_station_name = gets.chomp
      puts 'Ведите название конечной станции маршрута'
      end_station_name = gets.chomp
      start_station = stations.find { |station| station.name == start_station_name }
      end_station = stations.find { |station| station.name == end_station_name }
      if start_station.nil? || end_station.nil?
        puts 'Станции не найдены'
      else
        @routes << Route.new(start_station, end_station)
        puts "Маршрут: #{start_station_name}-#{end_station_name} успешно создан"
      end
    end
  end

  def operation
    puts ['Введите 1, если вы хотите добавить или удалить станцию в маршруте',
          'Введите 2, если вы хотите назначить маршрут поезду',
          'Введите 3, если вы хотите добавить или отцепить вагоны поезда',
          'Введите 4, если вы хотите перемещать поезд по маршруту вперед и назад',
          'Введите 0, если хотите вернуться в предыдущее меню'].join("\n")
    answer = gets.to_i
    clear
    case answer
    when 1
      if routes.empty?
        puts 'Маршрутов не существует'
      elsif stations.size < 3
        puts 'Недостаточное количество станций'
      else
        operation_with_station
      end
    when 2
      if @routes.empty?
        puts 'Маршрутов не существует'
      elsif @trains.empty?
        puts 'Поездов не существует'
      else
        add_route_to_train
      end
    when 3
      if @trains.empty?
        puts 'Не найдено ни одного поезда'
      else
        operation_with_wagon
      end
    when 4
      if trains.empty?
        puts 'Не найдено ни одного поезда'
      else
        operation_with_train
      end
    else
      menu
    end
    return_to_menu
  end

  def operation_with_station
    puts ['Введите 1, если вы хотите добавить станцию в маршруте',
          'Введите 2, если вы хотите удалить станцию в маршруте',
          'Введите 0, если хотите вернуться в предыдущее меню'].join("\n")
    answer = gets.to_i
    clear
    route = which_route
    if route.nil?
      puts 'Маршрут не найден'
    else
      puts 'В этом маршруте есть следующие станции:'
      route.info
      station = which_station
      if station.nil?
        puts 'Станция не найдена'
      else
        case answer
        when 1
          add_station_to_route(route, station)
        when 2
          remove_station_from_route(route, station)
        else
          operation
        end
      end
    end
  end

  def add_station_to_route(route, station)
    if route.list_stations.include?(station)
      puts 'Станция уже есть в списке остановок'
    else
      route.add_station(station)
      puts 'Станция добавлена в список остановок'
    end
  end

  def remove_station_from_route(route, station)
    if station == route.list_stations[0] || station == route.list_stations[-1]
      puts 'Начальную или конечную станции нельзя удалить'
    elsif route.list_stations.include?(station)
      route.delete_station(station)
      puts 'Станция удалена из маршрута'
    else
      puts 'Этой станции нет в маршруте'
    end
  end

  def add_route_to_train
    route = which_route
    train = which_train
    if route.nil?
      puts 'Маршрут не найден'
    elsif train.nil?
      puts 'Поезд не найден'
    else
      train.assign_route(route)
      puts "Поезду №#{train.number} назначен маршрут:"
      route.info
    end
  end

  def operation_with_wagon
    puts ['Введите 1, если вы хотите добавить вагон',
          'Введите 2, если вы хотите удалить вагон',
          'Введите 0, если хотите вернуться в предыдущее меню'].join("\n")
    answer = gets.to_i
    clear
    train = which_train
    if train.nil?
      puts 'Такого поезда не существует'
    else
      case answer
      when 1
        if @wagons.empty?
          puts 'Не найдено ни одного вагона'
        else
          add_wagon_to_train(train)
        end
      when 2
        remove_wagon_from_train(train)
      else
        menu
      end
    end
  end

  def add_wagon_to_train(train)
    wagon = find_wagon_by_type(train)
    if wagon.nil?
      puts 'Не найдено свободных вагонов такого типа'
    else
      train.add_wagon(wagon)
      wagons.delete(wagon)
      puts 'Вагон успешно прицеплен к поезду'
    end
  end

  def remove_wagon_from_train(train)
    if train.wagons.empty?
      puts 'У этого поезда нет вагонов'
    else
      wagon = train.wagons.last
      train.remove_wagon
      wagons << wagon
      puts 'Вагон успешно отцеплен от поезда'
    end
  end

  def operation_with_train
    train = which_train
    if train.nil?
      puts 'Такого поезда не существует'
    elsif train.current_station.nil?
      puts 'У поезда не задан маршрут'
    else
      puts ['Введите 1, если вы хотите переместить поезд вперед',
            'Введите 2, если вы хотите переместить поезд назад',
            'Введите 0, если хотите вернуться в предыдущее меню'].join("\n")
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
    end
  end

  def move_train_forvard(train)
    if train.current_station == train.route.list_stations.last
      puts 'Вы уже на конечной станции'
    else
      train.go_to_next_station
      puts "Поезд № #{train.number} перемещен на следующую станцию: #{train.current_station.name}"
    end
  end

  def move_train_back(train)
    if train.current_station == train.route.list_stations.first
      puts 'Вы на первой станции'
    else
      train.go_to_previous_station
      puts "Поезд № #{train.number} перемещен на предыдущую станцию: #{train.current_station.name}"
    end
  end

  def info
    puts ['Введите 1, если вы хотите посмотреть список станций',
          'Введите 2, если вы хотите посмотреть список поездов на станции',
          'Введите 0, если хотите вернуться в предыдущее меню'].join("\n")
    answer = gets.to_i
    clear
    if stations.empty?
      puts 'Станций не существует'
    else
      case answer
      when 1
        info_stations
      when 2
        info_trains_on_station
      else
        menu
      end
    end
    return_to_menu
  end

  def info_stations
    puts "Существуют такие станции: #{stations.map(&:name).join(', ')}"
  end

  def info_trains_on_station
    station = which_station
    if station.nil?
      puts 'Нет такой станции'
    elsif station.trains.empty?
      puts 'На станции нет поездов'
    else
      puts "На станции - #{station.name} находятся следующие поезда:"
      station.trains.each { |train| puts train.number }
      sleep 2
    end
  end

  private

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
    puts 'Ведите номер поезда который хотите создать'
    number = gets.chomp.strip
    if number.empty?
      puts 'Ошибка в номере поезда'
    elsif @trains.find { |train| train.number == number }
      puts 'Поезд с таким номером уже существует'
    else
      number
    end
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
    num_trains = gets.to_i
    @trains.find { |train| train.number.to_i == num_trains }
  end

  # метод для поиска соответствующего вагона типу поезда
  def find_wagon_by_type(train)
    if train.is_a? TrainCargo
      @wagons.find { |wagon| wagon.is_a? WagonCargo }
    elsif train.is_a? TrainPass
      @wagons.find { |wagon| wagon.is_a? WagonPass }
    end
  end
end
