def get_total_net_income(reports)
  total_net_income = 0
  reports.each do |report|
    gross_income = report.income - report.expense
    net_income = report.tax.income_tax(gross_income)
    total_net_income = total_net_income + net_income
  end
  return total_net_income
end