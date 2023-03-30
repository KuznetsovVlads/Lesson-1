class Train
    def initialize(number, type, amount_wagons)
        @number = number
        @type = type
        @amount_wagons = amount_wagons
        @speed = 0
        @route = nil
        @curent_station = nil
    end    

    def add_speed
        @speed += 20
        puts "Скорость поезда увеличилась на 20 км/ч"
    end

    def current_speed
        puts "текущая скорость #{@speed}"
    end

    def break_train
        @speed = 0
    end

    def how_many_wagons
        puts "Текущее количество вагонов: #{@amount_wagons}"
    end

    def add_wagon
        @amount_wagons += 1
    end

    def remove_wagon
        @amount_wagons -= 1 if @amount_wagons > 1
    end

    def assign_route(route)
        @route = route
        if @route
            @curent_station = @route.start
            puts "Маршрут назначен"
        else
            puts "Маршрут не назначен"
        end
    end

    def go_to_next_station
        index = @route.list_stations.index(@curent_station)
        if index == @route.list_stations.size
            puts "Вы уже на конечной станции"
        else
            @curent_station = @route.list_stations[index + 1]
        end
    end

    def go_to_previos_station
        index = @route.list_stations.index(@curent_station)
        if index == 0
            puts "Вы на первой станции"
        else
            @curent_station = @route.list_stations[index - 1]
        end
    end

    def where_i_am
        index = @route.list_stations.index(@curent_station)
        puts "Предыдущая станция - #{@route.list_stations[index - 1]}" if index >= 1
        puts "Текущая станция - #{@curent_station}"
        puts "Следующая станция - #{@route.list_stations[index + 1]}" if index < (@route.list_stations.size - 1)
    end
end