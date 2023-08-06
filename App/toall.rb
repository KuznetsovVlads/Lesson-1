# frozen_string_literal: true

# Модуль добавляет все созданные объекты в массив класса
module ToAll
  def self.included(base)
    base.extend(ClassMethods)
    base.include(InstanceMethods)
  end

  module ClassMethods
    def all
      @all ||= []
    end
  end

  module InstanceMethods
    def add_self_to_all
      self.class.all << self
    end
  end
end
