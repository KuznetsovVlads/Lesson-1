class Route
    attr_reader :list_stations

    def initialize(start, finish)
        @start = start
        @finish = finish
        @list_stations = [@start, @finish]
    end    

    def add_station(station)
        if @list_stations.include?(station)
            puts "Станция уже есть в списке остановок"
        else
            index_finish = @list_stations.index(@finish)
            @list_stations.insert(index_finish, station)
            puts "Станция #{station} добавлена в список остановок"
        end
    end

    def delete_station(station)
        if station == @start || station == @finish
            puts "Станция #{station} не может быть удалена из списка остановок, так как она является начальной или конечной остановкой маршрута"
          elsif @list_stations.include?(station)
            @list_stations.delete(station)
            puts "Станция #{station} удалена из списка остановок"
          else
            puts "Станция #{station} не найдена в списке остановок"
        end
    end

    def see_list
        puts @list_stations.join(" -> ")
    end

end