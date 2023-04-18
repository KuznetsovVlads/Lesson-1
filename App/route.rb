class Route
    attr_reader :list_stations

    def initialize(start, finish)
        @list_stations = [start, finish]
    end    
# добавляем промежуточную станцию в список
    def add_station(station)
        if station_include?(station)
            puts "Станция уже есть в списке остановок"
        else
            @list_stations.insert(-2, station) #"-2" добавляю станцию как предпоследний элемент в массиве
            puts "Станция #{station} добавлена в список остановок"
        end
    end

# удаляем промежуточную станцию из списка
    def delete_station(station)
        if station == @list_stations[0] || station == @list_stations[-1]
            puts "Станция #{station} не может быть удалена из списка остановок, 
            так как она является начальной или конечной остановкой маршрута"
        else
            @list_stations.delete(station)
        end
    end
# выводим список всех станций по-порядку от начальной до конечной
    def info
        info_list = []
        @list_stations.each do |station|
            info_list << station.name
        end
        puts info_list.join(" -> ")
    end
    
    private

#Внутренний метод для проверки существования станции в массиве
    def station_include?(station) 
        @list_stations.include?(station) 
    end

end

