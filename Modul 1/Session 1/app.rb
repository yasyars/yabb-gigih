require_relative 'person'

jin = Person.new("Jin Shakai",100,50)
puts jin

khotun = Person.new("Khotun Khan",500,50)
puts khotun

loop do
  jin.attack(khotun)
  break if khotun.die?

  khotun.attack(jin)
  break if jin.die?
end