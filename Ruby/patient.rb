class Patient

  attr_reader :medicines

  def initialize(medicines = [])
    @medicines = medicines
  end

  def clash(medicine_names, days_back=90)
    conflicting_medicines = @medicines.select { |m| medicine_names.include?(m.name) }
    if(prescriptions = conflicting_medicines.map(&:prescriptions).detect { |prescriptions| !prescriptions.empty? })
      prescription_end = prescriptions.first.dispense_date + (prescriptions.first.days_supply - 1)
      end_date = prescription_end < Date.today ? prescription_end : Date.today

      start_date = prescriptions.first.dispense_date < Date.today - days_back ? prescriptions.first.dispense_date : Date.today - days_back

      return (prescriptions.first.dispense_date..end_date).entries
    end
    []
  end
end
