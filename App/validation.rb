# frozen_string_literal: true

# Модуль для проверки правильности ввода данных
module Validation
  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  # Модуль для проверки правильности ввода данных в классе Station
  module ValidStation
    NAME_STATION_FORMAT = /^[a-z]{2,}$/i.freeze

    protected

    def validate!
      raise 'Не может быть пустым' if @name.nil?
      raise 'Не правильный формат' if @name !~ NAME_STATION_FORMAT
    end
  end

  # Модуль для проверки правильности ввода данных в классе Train
  module ValidTrain
    NUMBER_TRAIN_FORMAT = /^(\w|\d){3}-?(\w|\d){2}$/i.freeze

    protected

    def validate!
      raise 'Не может быть пустым' if @number.nil?
      raise 'Не правильный формат номера' if @number !~ NUMBER_TRAIN_FORMAT
    end

    def speed_train_zero?(train)
      raise 'Поезд должен быть остановлен' unless train.speed.zero?
    end
  end

  # Модуль для проверки правильности ввода данных в классе Route
  module ValidRoute
    protected

    def validate!
      raise 'Станции не найдены' if @list_stations.compact.size < 2
      raise 'Ошибка данных' unless @list_stations[0].is_a?(Station) || @list_stations[1].is_a?(Station)
    end
  end

  # Модуль для проверки правильности ввода данных в классе WagonPass
  module ValidWagonPass
    protected

    def validate!
      raise 'Ошибка данных' unless @total_seats.is_a?(Integer)
      raise 'Неверное значение мест' if @total_seats <= 0 || @total_seats > 100
    end
  end

  # Модуль для проверки правильности ввода данных в классе WagonCargo
  module ValidWagonCargo
    protected

    def validate!
      raise 'Ошибка данных' unless @total_volume.is_a?(Integer)
      raise 'Неверное значение объема' if @total_volume <= 0 || @total_volume > 250
    end
  end
end
