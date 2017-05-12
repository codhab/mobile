require 'test_helper'

class Person::Test < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, Person
  end
end
