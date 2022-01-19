class Patient

  attr_reader :medicines

  def initialize(medicines = [])
    @medicines = medicines
  end

  def clash(medicine_names, days_back=90)
    conflicting_medicines = @medicines.select { |m| medicine_names.include?(m.name) }
    prescriptions = conflicting_medicines.flat_map(&:prescriptions)

    prescriptions.flat_map do |prescription|
      prescription.dates_taken_in_range(Date.today - days_back)
    end.uniq.sort.reverse
  end
end
