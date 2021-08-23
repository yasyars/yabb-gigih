require_relative 'shape'

class Circle < Shape
  attr_accessor :radius

  def initialize(name, radius)
    @name = name
    @radius = radius
  end

  def calculate_area
    3.14 * @radius * @radius
  end
end
