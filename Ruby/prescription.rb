
class Prescription

  attr_reader :dispense_date, :days_supply

  def initialize(options = {})
    @dispense_date = options[:dispense_date] ||= Date.today
    @days_supply = options[:days_supply] ||= 30
  end

  def end_date
    @dispense_date + @days_supply - 1
  end

  def dates_taken_in_range(begin_date)
    start_date = [@dispense_date, begin_date].max
    end_date = [self.end_date, Date.today].min
    (start_date..end_date).entries
  end
end
