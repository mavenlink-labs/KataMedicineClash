class Patient

  attr_reader :medicines

  def initialize(medicines = [])
    @medicines = medicines
  end

  def clash(medicine_names, days_back=90)
    conflicting_medicines = @medicines.select { |m| medicine_names.include?(m.name) }
    prescriptions = conflicting_medicines.flat_map(&:prescriptions)

    prescriptions.flat_map do |prescription|
      start_date = [prescription.dispense_date, Date.today - days_back].max
      end_date = [prescription.end_date, Date.today].min
      (start_date..end_date).entries
    end.uniq
  end
end
