require 'minitest/autorun'
require_relative 'patient'
require_relative 'medicine'
require_relative 'prescription'
require 'date'

class PatientTest < Minitest::Test
  def test_clash_with_empty_list
    patient = Patient.new
    assert_equal [], patient.clash([])
  end

  def test_no_match_in_medicine_list
    patient = Patient.new
    assert_equal [], patient.clash(['oxy'])
  end

  def test_single_medicine_no_prescription
    medicine = Medicine.new('oxy', [])
    patient = Patient.new([medicine])

    assert_equal [], patient.clash(['oxy'])
  end

  def test_single_medicine_with_prescription
    medicine = Medicine.new('oxy', [Prescription.new])
    patient = Patient.new([medicine])

    assert_equal [Date.today], patient.clash(['oxy'])
  end

  def test_single_medicine_with_prescription_from_3_days
    three_days_ago = Date.today - 3
    two_days_ago = Date.today - 2
    one_days_ago = Date.today - 1
    medicine = Medicine.new('oxy', [Prescription.new(dispense_date: three_days_ago)])
    patient = Patient.new([medicine])

    assert_equal [three_days_ago, two_days_ago, one_days_ago, Date.today], patient.clash(['oxy'])
  end

  def test_medicine_names_not_conflicting
    fake = Medicine.new('fake', [Prescription.new()])
    patient = Patient.new([fake])

    assert_equal [], patient.clash(['oxy'])
  end

  def test_old_prescription
    three_days_ago = Date.today - 3

    oxy = Medicine.new('oxy', [Prescription.new(dispense_date: three_days_ago, days_supply: 1)])
    patient = Patient.new([oxy])

    assert_equal [three_days_ago], patient.clash(['oxy'])
  end

  def test_days_back
    three_days_ago = Date.today - 3
    oxy = Medicine.new('oxy', [Prescription.new(dispense_date: three_days_ago, days_supply: 1)])
    patient = Patient.new([oxy])

    assert_equal [], patient.clash(['oxy'], 1)
  end

  def test_multiple_prescriptions
    three_days_ago = Date.today - 3
    five_days_ago = Date.today - 5
    oxy = Medicine.new('oxy',
          [Prescription.new(dispense_date: five_days_ago, days_supply: 1), Prescription.new(dispense_date: three_days_ago, days_supply: 1)])

    patient = Patient.new([oxy])
    assert_equal [five_days_ago, three_days_ago], patient.clash(['oxy'])
  end

  def test_multiple_prescriptions_same_day
    three_days_ago = Date.today - 3
    four_days_ago = Date.today - 4
    oxy = Medicine.new('oxy',
                       [Prescription.new(dispense_date: four_days_ago, days_supply: 2), Prescription.new(dispense_date: three_days_ago, days_supply: 1)])

    patient = Patient.new([oxy])
    assert_equal [four_days_ago, three_days_ago], patient.clash(['oxy'])
  end

  # test with multiple medicine_names

  def test_multiple_medicine_names
    three_days_ago = Date.today - 3
    four_days_ago = Date.today - 4
    two_days_ago = Date.today - 2
    oxy = Medicine.new("oxy",
                       [Prescription.new(dispense_date: four_days_ago, days_supply: 2)])
    percocet = Medicine.new("percocet",
                       [Prescription.new(dispense_date: three_days_ago, days_supply: 2)])


    patient = Patient.new([oxy, percocet])
    assert_equal [four_days_ago, three_days_ago, two_days_ago], patient.clash(["oxy", "percocet"])
  end

  # test with multiple medicines
  # Should dates be ordered from oldest to newest?
end
