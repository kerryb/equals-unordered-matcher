RSpec::Matchers.define :equal_unordered do |expected|
  match do |actual|
    compare(expected, actual)
  end

  def compare(expected, actual)
    case [expected.respond_to?(:each), actual.respond_to?(:each)]
    in [true, true]
      compare_unordered(Array(expected), Array(actual))
    in [false, false]
      expected == actual
    else
      false
    end
  end

  def compare_unordered(expected, actual)
    return true if expected.empty? && actual.empty?
    if index = actual.find_index {|element| compare(expected.first, element) }
      compare_unordered(expected.drop(1), actual.reject.with_index{|_v, i| i == index })
    else
      false
    end
  end
end
