# frozen_string_literal: true

# Модуль для подсчета созданных объектов
module InstanceCounter
  def self.included(base)
    base.extend(ClassMethods)
    base.include(InstanceMethods)
  end

  module ClassMethods
    def instances
      @instances ||= 0
    end

    def increment_instances
      @instances ||= 0
      @instances += 1
    end
  end

  module InstanceMethods
    def register_instance
      self.class.increment_instances
    end
  end
end
