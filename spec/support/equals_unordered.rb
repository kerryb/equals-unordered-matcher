RSpec::Matchers.define :equal_unordered do |expected|
  match do |actual|
    expected == actual
  end
end
