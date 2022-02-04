RSpec::Matchers.define :equal_unordered do |expected|
  match do |actual|
    Array(expected).sort == Array(actual).sort
  end
end
