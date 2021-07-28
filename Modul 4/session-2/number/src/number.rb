class Number

  def initialize(array)
    @array = array
  end

  # def stop(temp)
  #   temp[temp.size-1]!=9
  # end

  # def recur(temp)
  #   temp[temp.size-1]+=1
  # end


  def increment
    if @array[@array.size-1]!= 9
      @array[@array.size-1]+=1
    else
      @array[@array.size-1] = 0
      @array[@array.size-2] +=1
    end

    return @array
  end

end