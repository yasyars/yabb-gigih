require_relative '../rectangle'
require_relative '../triangle'
require_relative '../shape'
require_relative '../circle'

require_relative '../shape_calculator'

describe ShapeCalculator do 
  it "can calculate the area of a rectangle" do
    rectangle = Rectangle.new("rectangle", 2, 3)
    shape_calculator = ShapeCalculator.new
    expect(shape_calculator.calculate_area(rectangle)).to eq(6)
  end

  it "can calculate the area of a triangle" do
    triangle = Triangle.new("triangle", 2, 3)
    shape_calculator = ShapeCalculator.new
    expect(shape_calculator.calculate_area(triangle)).to eq(3)
  end

  it "can calculate the area of a circle" do
    circle = Circle.new("circle", 2)
    shape_calculator = ShapeCalculator.new
    expect(shape_calculator.calculate_area(circle)).to eq(4*3.14)
  end
end
