def average_income_in(date_range)
  total_days = (date_range.end_date - date_range.start_date).to_i
  total_income / total_days
end

class date_range
  attr_reader :start_date, :end_date

  def initialize(start_date,end_date)
    @start_date = start_date
    @end_date = end_date
  end
end