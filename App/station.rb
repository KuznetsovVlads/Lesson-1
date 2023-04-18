class Station
    attr_accessor :trains
    attr_reader :name

    def initialize(name)
        @name = name
        @trains = []
    end

# принимаем поезда (по одному за раз)
    def add_train(train)
        @trains << train
    end

# возвращаем список всех поездов на станции, находящиеся в текущий момент
    def current_trains 
        list_trains = []
        @trains.each do |train|
            list_trains << train.number
        end
        puts list_trains.join(", ")
    end

# возвращаем список поездов на станции по типу: кол-во грузовых, пассажирских
    def trains_by_type(type)
        counter = 0
        @trains.each do |train|
            counter += 1 if train.type == type
        end
        puts "#{counter} #{type}"
    end

# отправляем поезда
    def send_train(train)
        train.go_to_next_station
    end
end