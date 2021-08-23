require_relative './shape'

class Rectangle < Shape
  attr_accessor :name, :length, :width

  def initialize(name, length, width)
    @name = name
    @length = length
    @width = width
  end

  def calculate_area
    @width * @length
  end
end
