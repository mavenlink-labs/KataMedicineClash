class Medicine

  attr_reader :name, :prescriptions

  def initialize(name, prescriptions)
    @name = name
    @prescriptions = prescriptions
  end

end
