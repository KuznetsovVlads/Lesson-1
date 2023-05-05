class Route
  attr_reader :list_stations

  def initialize(start, finish)
    @list_stations = [start, finish]
  end

  # добавляем промежуточную станцию в список
  def add_station(station)
    @list_stations.insert(-2, station) unless @list_stations.include?(station)
  end

  # удаляем промежуточную станцию из списка
  def delete_station(station)
    return if station == @list_stations[0] || station == @list_stations[-1]

    @list_stations.delete(station)
  end

  # выводим список всех станций по-порядку от начальной до конечной
  def info
    puts @list_stations.map(&:name).join(' -> ')
  end
end
