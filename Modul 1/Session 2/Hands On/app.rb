require_relative 'person'
require_relative 'hero'

jin = Hero.new("Jin Shakai",100,50,0.8)
puts jin

khotun = Person.new("Khotun Khan",500,50)
puts khotun

loop do
  jin.attack(khotun)
  break if khotun.die?

  khotun.attack(jin)
  break if jin.die?
end