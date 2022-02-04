require_relative "support/equals_unordered"

describe "equals_unordered matcher" do
  it "matches identical primitive objects" do
    expect(:foo).to equal_unordered(:foo)
  end

  it "doesn't match different primitive objects" do
    expect(:foo).not_to equal_unordered(:bar)
  end
end
