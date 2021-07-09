class Villain < Person
  def initialize(name, hitpoint, attack_damage)
    super(name,hitpoint, attack_damage)
    @flee_percentage = 0.5
    @fled = false
  end 

  def take_damage(enemy_damage)
    super(enemy_damage)
    if @hitpoint <= 50 && @alive
      flee if rand < @flee_percentage
    end
  end

  def flee
    @fled = true 
    puts "#{@name} has fled the battlefield with #{@hitpoint} left"
  end

  def flee?
    @fled
  end

  def removed?
    die? || flee?
  end

end