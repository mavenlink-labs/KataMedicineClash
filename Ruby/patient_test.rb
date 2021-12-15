require 'minitest/autorun'
require_relative 'patient'

class PatientTest < Minitest::Test
  def test_clash_with_empty_list
    patient = Patient.new
    patient.clash
  end

  # empty list of medicine names returns empty list
  # not match in medicine names returns empty list
  # single medicine being taken clashing
  # medicine started being taken before date but supply has not run out
  # medicine in list but not currently taking
end
