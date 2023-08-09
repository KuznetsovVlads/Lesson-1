# frozen_string_literal: true

# Модуль добавляет все созданные объекты в массив класса
module ToAll
  def self.included(base)
    base.extend(ClassMethods)
    base.include(InstanceMethods)
  end

  # Модуль для работы на уровне метода класса
  module ClassMethods
    def all
      @all ||= []
    end
  end

  # Модуль для работы на уровне методов класса
  module InstanceMethods
    def add_self_to_all
      self.class.all << self
    end
  end
end
