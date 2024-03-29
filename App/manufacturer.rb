# frozen_string_literal: true

# Модуль для указания фирмы производителя
module Manufacturer
  attr_reader :manufacturer_name

  def add_manufacturer(manufacturer)
    @manufacturer_name = manufacturer
  end
end
