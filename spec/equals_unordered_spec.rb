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

  it "matches identical hashes" do
    expect({a: 1, b: 2}).to equal_unordered({a: 1, b: 2})
  end

  it "doesn't match hashes with different keys" do
    expect({a: 1, b: 2}).not_to equal_unordered({a: 1, c: 2})
  end

  it "doesn't match hashes with different values" do
    expect({a: 1, b: 2}).not_to equal_unordered({a: 1, b: 3})
  end

  it "doesn't match hashes with extra keys" do
    expect({a: 1, b: 2}).not_to equal_unordered({a: 1, b: 2, c: 3})
  end

  it "matches deeply-nested arrays with elements in a different order" do
    expect([1, [2, [3, 4], 5], 6]).to equal_unordered([[5, [4, 3], 2], 6, 1])
  end

  it "doesn't match deeply-nested arrays with different elements" do
    expect([1, [2, [3, 4], 5], 6]).not_to equal_unordered([[5, [4, 0], 2], 6, 1])
  end

  it "matches deeply-nested hashes" do
    expect({a: {b: 1, c: {d: 2, e: 3}}, f: 4}).to equal_unordered({f: 4, a: {c: {e: 3, d: 2}, b: 1}})
  end

  it "doesn't match deeply-nested hashes with different keys" do
    expect({a: {b: 1, c: {d: 2, e: 3}}, f: 4}).not_to equal_unordered({f: 4, a: {c: {x: 3, d: 2}, b: 1}})
  end

  it "doesn't match deeply-nested hashes with different values" do
    expect({a: {b: 1, c: {d: 2, e: 3}}, f: 4}).not_to equal_unordered({f: 4, a: {c: {e: 9, d: 2}, b: 1}})
  end

  it "matches deeply-nested shuffled mixtures of hashes and arrays" do
    expect({
      a: 1,
      [42, :foo] => [1, :bar, [2, 3], {x: "foo", "bar" => [:foo, "bar"]}],
      b: [1, 2, 3],
      true => [10, [11, 12, 13], {a: {b: {c: 99, d: 100}}}]
    }).to equal_unordered({
      true => [[11, 13, 12], 10, {a: {b: {d: 100, c: 99}}}],
      [:foo, 42] => [:bar, 1, [3, 2], {"bar" => ["bar", :foo], x: "foo"}],
      a: 1,
      b: [3, 1, 2]
    })
  end

  it "doesn't match deeply-nested non-equivalent mixtures of hashes and arrays" do
    expect({
      a: 1,
      [42, :foo] => [1, :bar, [2, 3], {x: "foo", "bar" => [:foo, "bar"]}],
      b: [1, 2, 3],
      true => [10, [11, 12, 13], {a: {b: {c: 99, d: 100}}}]
    }).not_to equal_unordered({
      true => [[11, 13, 12], 10, {a: {b: {d: 100, c: 99}}}],
      [:foo, 42] => [:bar, 1, [3, 2], {"bar" => ["bar", :foo], x: "foo"}],
      a: 1,
      b: [3, 1, 4]
    })
  end
end
