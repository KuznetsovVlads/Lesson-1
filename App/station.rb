class Station
    def initialize(name)
        @name = name
        @trains = []
    end
    
    def add_train(train)
        @trains << train
        puts "Поезд #{train.number} прибыл на станцию #{@name}"
    end

    def trains
        @trains
    end

    def trains_by_type(type)
        @trains.select { |train| train.type == type }
    end
 
    def send_train(train)
        @trains.delete(train)
        puts "Поезд #{train.number} отправился со станции #{@name}"
    end
end