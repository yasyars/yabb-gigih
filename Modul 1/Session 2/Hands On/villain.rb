class Villain < Person
  def initialize(name, hitpoint, attack_damage)
    super(name,hitpoint, attack_damage)
    @flee_percentage = 0.5
    @fled = false
  end 

  def take_damage(enemy_damage)
    @hitpoint-=enemy_damage
    flee if rand < @flee_percentage
  end

  def attack(other_player)
    raise NotImplementedError, 'You must implement the attack' 
  end

  def flee
    @fled = true
    puts "#{@name} has fled the battlefield with #{@hitpoint} left"
  end

  def flee?
    @fled
  end

end

class MongolArcher < Villain
  def attack(other_person)
      puts "#{@name} shoots an arrow at #{other_person.name} with #{@attack_damage} damage."
      other_person.take_damage(@attack_damage)
  end
end

class MongolSpearman < Villain
  def attack(other_person)
    puts "#{@name} thrusts #{other_person.name} with #{@attack_damage} damage."
    other_person.take_damage(@attack_damage)
  end
end

class MongolSwordsman < Villain 
  def attack(other_person)
    puts "#{@name} slashes #{other_person.name} with #{@attack_damage} damage."
    other_person.take_damage(@attack_damage)
  end
end
