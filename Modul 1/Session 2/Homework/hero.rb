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

  def restore_hitpoint(hitpoint)
    @hitpoint+=hitpoint
  end

  def heal(other_hero)
    restore_hitpoint = 20 #asumsi selalu 20
    other_hero.restore_hitpoint(restore_hitpoint) 
    puts "#{@name} heals #{other_hero.name}, restoring #{restore_hitpoint} hitpoints"
  end

end