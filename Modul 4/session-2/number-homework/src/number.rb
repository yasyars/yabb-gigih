class Number
  def initialize(array)
    @array = array
  end

  def recur(temp_array)
    if temp_array[-1] !=9
      temp_array[-1]+=1
      temp_array
    elsif temp_array.size ==1
      temp_array[0]= 0
      temp_array.unshift(1)
    else
      temp = recur(temp_array[0...-1])
      temp.append(0)
      temp
    end
  end

  def increment
    recur(@array)
  end

end