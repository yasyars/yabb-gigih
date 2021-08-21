def get_total_net_income(reports)
  total_net_income = 0
  reports.each do |report|
    total_net_income += get_net_income(report)
  end
  total_net_income
end

def get_net_income(report)
  gross_income = get_gross_income(report)
  report.tax.income_tax(gross_income)
end

def get_gross_income(report)
  report.income - report.expense
end