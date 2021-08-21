class EnterpriseTax < Tax
  def initialize
    super('ENTERPRISE')
  end

  def income_tax(gross_income)
    gross_income * 0.2
  end
end