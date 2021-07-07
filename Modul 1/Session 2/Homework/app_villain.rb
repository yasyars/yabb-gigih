require_relative 'person'
require_relative 'hero'
require_relative 'villain'

def update_villain(villains)
  villains.each do |villain|
    villains.delete(villain) if villain.die? || villain.flee?
  end
  
  return villains
end

def update_heroes(heroes)
  heroes.each do |hero|
    heroes.delete(hero) if hero.die?
  end

  return heroes
end

jin = Hero.new("Jin Shakai",100,50,0.8)
yuna = Hero.new("Yuna",90,45,0)
sensei = Hero.new("Sensei Ishikawa",80,60,0)
heroes = [jin,yuna,sensei]

archer = MongolArcher.new("Mongol Archer",80,40,)
spearman = MongolSpearman.new("Mongol Spearman", 120, 60)
swordsman = MongolSwordsman.new("Mongol Swordsman", 100,50)

villains = [archer,spearman,swordsman]

i = 1
until (villains.empty? || heroes.empty?) do
  puts "================Turn #{i} ================"
  puts "\n"

  heroes.each do |hero|
    puts hero
  end
  puts "\n"

  villains.each do |villain|
    puts villain
  end
  puts "\n"

  unless jin.die? 
    puts "As Jin Sakai, what do you want to do this turn?"
    puts "1) Attack an enemy"
    unless heroes.drop(1).empty?
      puts "2) Heal an ally"
    end
    puts "Enter your answer: "
    opt = gets.chomp.to_i

    if opt==1
      puts "Which enemy you want to attack?"
      villains.each_with_index do |villain, index|
        puts "#{index+1}) #{villain.name}"
      end
      puts "Enter your answer: "

      opt_vil = gets.chomp.to_i
      jin.attack(villains[opt_vil-1])
      villains = update_villain(villains)
    else #opt 2
      puts "Which ally you want to heal?"
      heroes.drop(1).each_with_index do |ally, index|
        puts "#{index+1}) #{ally.name}"
      end
      puts "Enter your answer: "

      opt_al = gets.chomp.to_i
      jin.heal(heroes[opt_al])
    end

    allies = heroes.drop(1)
  else
    allies = heroes
  end


  allies.each do |ally|
    ally.attack(villains[rand(villains.size)])
    villains = update_villain(villains)
    break if villains.empty?
  end

  
  puts "\n"
  villains.each do |villain|
    villain.attack(heroes[rand(heroes.size)])
    heroes = update_heroes(heroes) 
    break if heroes.empty?
  end

  puts "\n"
  i+=1
end