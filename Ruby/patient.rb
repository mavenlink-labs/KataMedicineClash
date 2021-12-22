class Patient

  attr_reader :medicines

  def initialize(medicines = [])
    @medicines = medicines
  end

  def clash(medicine_names, days_back=90)
    prescription = @medicines.detect { |medicine| medicine.prescriptions != [] }
    if(prescriptions.present?)
      return prescriptions.dispense_date [Date.today]
    end
    []
  end
end
