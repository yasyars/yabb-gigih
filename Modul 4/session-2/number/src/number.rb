class Number

  def initialize(array)
    @array = array
  end

  def increment
    if @array[@array.size-1]!= 9
      @array[@array.size-1]+=1
    end

    return @array
  end

end