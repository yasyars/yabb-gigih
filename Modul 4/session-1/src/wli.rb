class WLI 
  attr_accessor :names
  attr_reader :names

  def initialize
    @names
  end

  def likes
    if @names.nil?
      "no one likes this"
    elsif @names.size==1
      "#{@names.first} likes this"
    elsif @names.size>3
      "#{@names[0..1].join(', ')} and #{@names.size-2} others like this"
    else
      "#{@names[0...-1].join(', ')} and #{@names[@names.size-1]} like this"
    end
  end

end