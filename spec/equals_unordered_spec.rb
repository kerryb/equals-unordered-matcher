require_relative "support/equals_unordered"

describe "equals_unordered matcher" do
  it "matches identical primitive objects" do
    expect(:foo).to equal_unordered(:foo)
  end

  it "doesn't match different primitive objects" do
    expect(:foo).not_to equal_unordered(:bar)
  end

  it "matches identical arrays" do
    expect([1, 2, 3]).to equal_unordered([1, 2, 3])
  end

  it "matches arrays with the same elements in a different order" do
    expect([1, 2, 3]).to equal_unordered([2, 1, 3])
  end

  it "matches arrays with repeated elements in a different order" do
    expect([1, 2, 3, 2]).to equal_unordered([2, 2, 1, 3])
  end

  it "doesn't match arrays with different elements" do
    expect([1, 2, 3]).not_to equal_unordered([1, 1, 3])
  end

  it "doesn't match arrays with different numbers of elements" do
    expect([1, 2, 3]).not_to equal_unordered([1, 2])
  end

  it "doesn't matches arrays with repeated elements in one but not the other" do
    expect([1, 2, 3, 2]).not_to equal_unordered([2, 1, 3])
  end
end
