require_relative 'person'
require_relative 'hero'
require_relative 'villain'

jin = Hero.new("Jin Shakai",100,50,0.8)

archer = MongolArcher.new("Mongol Archer",80,40,)
spearman = MongolSpearman.new("Mongol Spearman", 120, 60)
swordsman = MongolSwordsman.new("Mongol Swordsman", 100,50)

villains = [archer,spearman,swordsman]

i = 1
until (villains.empty? || jin.die?) do
  puts "================Turn #{i} ================"
  puts "\n"

  puts jin
  villains.each do |villain|
    puts villain
  end
  puts "\n"

  jin.attack(villains[rand(villains.size)])
  villains.each do |villain|
    villains.delete(villain) if villain.die? || villain.flee?
  end
  puts "\n"

  villains.each do |villain|
    villain.attack(jin) 
  end

  puts "\n"
  i+=1
end