class PayDeterminer
  def initialize(working_level, tax)
    @working_level = working_level
    @tax = tax
  end

	def get_pay
		case @working_level
		when 1
			get_pay(3000000)
		when 2
			get_pay(4000000)
		when 3
      get_pay(5000000)
		else "unknown level"
		end
	end

  def calculate_pay(price)
    price - (price * @tax)
  end
end