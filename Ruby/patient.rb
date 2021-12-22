class Patient

  attr_reader :medicines

  def initialize(medicines = [])
    @medicines = medicines
  end

  def clash(medicine_names, days_back=90)
    conflicting_medicines = @medicines.select { |m| medicine_names.include?(m.name) }
    if(prescriptions = conflicting_medicines.map(&:prescriptions).detect { |prescriptions| !prescriptions.empty? })
      return (prescriptions.first.dispense_date..Date.today).entries
    end
    []
  end
end
