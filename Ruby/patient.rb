class Patient

  attr_reader :medicines

  def initialize(medicines = [])
    @medicines = medicines
  end

  def clash(medicine_names, days_back=90)
    conflicting_medicines = @medicines.select { |m| medicine_names.include?(m.name) }
    if(prescriptions = conflicting_medicines.map(&:prescriptions).detect { |prescriptions| !prescriptions.empty? })

      start_date = [prescriptions.first.dispense_date, Date.today - days_back].max
      end_date = [prescriptions.first.end_date, Date.today].min

      return (start_date..end_date).entries
    end
    []
  end
end
