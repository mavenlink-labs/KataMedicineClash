class Patient

  attr_reader :medicines

  def initialize(medicines = [])
    @medicines = medicines
  end

  def clash(medicine_names, days_back=90)
    @medicines
  end
end
