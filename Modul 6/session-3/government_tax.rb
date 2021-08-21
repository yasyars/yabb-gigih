class GovernmentTax < Tax
  def initialize
    super('GOVERNMENT')
  end

  def income_tax(gross_income)
    gross_income * 0.05
  end
end