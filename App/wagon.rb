# Класс для создания вагонов. Класс только как родительский
class Wagon
  attr_reader :type

  def initialize
    @type = nil
  end
end
