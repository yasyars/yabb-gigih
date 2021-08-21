class IndividualTax < Tax
  def initialize
    super('INDIVIDUAL')
  end
  
  def income_tax(gross_income)
    gross_income * 0.1
  end
end