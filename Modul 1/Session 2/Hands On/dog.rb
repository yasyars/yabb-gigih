class Dog
  def initialize(breed)
    @breed = breed
  end

  def bark
    puts "woof woof"
  end
end

class Lab < Dog
  def initialize(breed, name)
    super(breed)
    @name = name
  end

  def to_s
    "(#@breed, #@name)"
  end

  def bark()
    puts "labrador"
    super
  end

end

labr= Lab.new("Labrador","Benzy")
puts labr
labr.bark