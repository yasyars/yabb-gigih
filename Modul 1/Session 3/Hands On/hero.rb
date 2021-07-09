class Hero < Person
  def initialize(name, hitpoint, attack_damage)
    super(name,hitpoint, attack_damage)
    @deflect_percentage =0.8
    @heal_point = 50
  end 

  def take_damage(enemy_damage)
    if rand < @deflect_percentage
      deflect
    else
      super(enemy_damage)
    end
  end

  def deflect
    puts "#{@name} deflects the attack"
  end

  def restore_hitpoint(hitpoint)
    @hitpoint+=hitpoint
  end

  def heal(other_hero)
    other_hero.restore_hitpoint(@heal_point) 
  end

end