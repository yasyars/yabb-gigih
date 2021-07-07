class Grandfather
  def initialize
    puts "In Grandfather class"
  end

  def grandfather_method
    puts "Grandfather method calls"
  end
end

class Father < Grandfather
  def initialize
    puts "In Father class"
  end

  def grandfather_method
    puts "Father method calls"
  end
end

class Son < Father
  def initialize
    puts "In Son class"
  end
end

son = Son.new
son.grandfather_method
father = Father.new

son = father
son.grandfather_method