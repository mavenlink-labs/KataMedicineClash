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
  # single medicine being taken clashing
  # medicine started being taken before date but supply has not run out
  # medicine in list but not currently taking
end
