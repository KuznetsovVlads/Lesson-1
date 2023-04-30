class Route
  attr_reader :list_stations

  def initialize(start, finish)
    @list_stations = [start, finish]
  end

  # добавляем промежуточную станцию в список
  def add_station(station)
    @list_stations.insert(-2, station) # "-2" добавляю станцию как предпоследний элемент в массиве
  end

  # удаляем промежуточную станцию из списка
  def delete_station(station)
    @list_stations.delete(station)
  end

  # выводим список всех станций по-порядку от начальной до конечной
  def info
    info_list = []
    @list_stations.each do |station|
      info_list << station.name
    end
    puts info_list.join(' -> ')
  end

end