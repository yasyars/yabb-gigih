class Person
  # attr_accessor :hitpoint
  attr_reader :name, :attack_damage

	def initialize(name,hitpoint,attack_damage)
		@hitpoint = hitpoint
		@attack_damage =attack_damage
		@name = name
	end

  def take_damage(enemy_damage)
    @hitpoint-= enemy_damage
  end

  def attack(other_person)
    puts "#{@name} attacks #{other_person.name} with #{@attack_damage} damage."
    other_person.take_damage(@attack_damage)
  end
  
  def to_s
    "#{@name} has #{@hitpoint} hitpoint and #{@attack_damage} attack damage."
  end

  def die?
    if @hitpoint<=0
      puts "#{@name} dies."
      true
    end    
  end

end