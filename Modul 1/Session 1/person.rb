class Person
  attr_accessor :hitpoint
  attr_reader :name, :attack_damage

	def initialize(name,hitpoint,attack_damage)
		@hitpoint = hitpoint
		@attack_damage =attack_damage
		@name = name
	end

  def attacked(enemy_damage)
    p = rand(10)
    if p<8
      puts "#{@name} deflects the attack."
    else
      @hitpoint-= enemy_damage
    end

    puts self
  end

  def attack(other_player)
    puts "#{@name} attacks #{other_player.name} with #{@attack_damage} damage."
    other_player.attacked(@attack_damage)
  end
  
  def to_s
    "#{@name} has #{@hitpoint} hitpoint and #{@attack_damage} attack damage.\n\n"
  end

  def die?
    if @hitpoint<=0
      puts "#{@name} dies."
      true
    end    
  end

end