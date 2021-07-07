class Bird
  def preen
    puts "I am cleaning my feathers."
  end

  def fly
    puts "I am flying"
  end
end

class Penguin < Bird
  def fly 
    puts "Sorry, I'd rather swim"
  end
end

penguin = Penguin.new
penguin.preen
penguin.fly