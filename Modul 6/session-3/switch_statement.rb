class Tax
  def initialize(type)
    @type = type
  end

  def income_tax(gross_income)
    gross_income * 0.3
    end
  end
end

class GovernmentTax < Tax
  def initialize
    super('GOVERNMENT')
  end

  def income_tax(gross_income)
    gross_income * 0.05
  end
end

class EnterpriseTax < Tax
  def initialize
    super('ENTERPRISE')
  end

  def income_tax(gross_income)
    gross_income * 0.2
  end
end

class IndividualTax < Tax
  def initialize
    super('INDIVIDUAL')
  end
  
  def income_tax(gross_income)
    gross_income * 0.1
  end
end
