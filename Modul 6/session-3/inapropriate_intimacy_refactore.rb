class Report
  attr_reader :income, :expense, :tax, :date

  def initialize(income,expense,type,date)
    @income = income
    @expense = expense
    @type = Tax.new(@type)
    @date = date
  end

  def get_income_tax(gross_income)
    get_tax.income_tax(gross_income)
  end

  def get_tax
  end
end

class Re[pr]

#Client code
income_tax = report.get_income_tax(gross_income)