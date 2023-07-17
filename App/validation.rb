# Модуль для проверки правильности ввода данных
module Validation
  def valid?
    validate!
    true
  rescue
    false
  end

  module ValidStation
    NAME_STATION_FORMAT = /^[a-z]{2,}$/i

    protected

    def validate!
      raise 'Не может быть пустым' if @name.nil?
      raise 'Не правильный формат' if @name !~ NAME_STATION_FORMAT
    end
  end

  module ValidTrain
    NUMBER_TRAIN_FORMAT = /^(\w|\d){3}-?(\w|\d){2}$/i

    protected

    def validate!
      raise 'Не может быть пустым' if @number.nil?
      raise 'Не правильный формат номера' if @number !~ NUMBER_TRAIN_FORMAT
    end

    def speed_train_zero?(train)
      raise 'Поезд должен быть остановлен' unless train.speed.zero?
    end
  end

  module ValidRoute
    protected

    def validate!
      raise 'Станции не найдены' if @list_stations.compact.size < 2
      raise 'Ошибка данных' unless @list_stations[0].is_a?(Station) || @list_stations[1].is_a?(Station)
    end
  end
end
