class Hero < Person
  def initialize(name, hitpoint, attack_damage, deflect_percentage)
    super(name,hitpoint, attack_damage)
    @deflect_percentage = deflect_percentage
  end 

  def take_damage(enemy_damage)
    if rand < @deflect_percentage
      puts "#{@name} deflects the attack"
      super(0)
    else
      super(enemy_damage)
    end
  end

end