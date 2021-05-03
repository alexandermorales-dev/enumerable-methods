require './script'

describe Enumerable do
  describe '#my_each' do
    it 'prints each item in the iterable and returns original array' do
      expect([1, 2, 3].my_each { |x| puts x }).to eql([1, 2, 3])
    end

    it 'returns an Enumerator when no block is given' do
      expect([1, 2, 3].my_each).not_to be_a(Array)
    end
    
    a = { :b => 1, :c => 2, :d => 'a'}
    it 'prints keys and values and returns original hash' do
      expect(a.my_each { |x,y| puts "this is #{x} and this is #{y}" }).to be_a(Hash)
    end

    it "returns original array unmutated" do
      expect([1, 2, 3].my_each { |x| x + 1 }).to eq([1, 2, 3])
    end
  end

  describe '#my_each_with_index' do
    it 'prints current item and its index and returns original array' do
      expect([4, 5, 6].my_each_with_index { |x, v| puts "#{x} is at position #{v}" }).to eql([4, 5, 6])
    end

    it 'returns enumerator when no block given' do
      expect([4, 5, 6].my_each_with_index).to be_a(Enumerator)
    end

    it 'original array is not mutated' do
      expect([4, 5, 6].my_each_with_index { |x, v| puts "#{x} is at position #{v}" }).to eql([4, 5, 6])
    end

    it 'returns range when called on a range' do
      expect((1..3).my_each_with_index { |x| x}).to eql(1..3)
    end

    a = { :b => 1, :c => 2, :d => 'a'}
    it 'returns hash when called on a Hash' do
      expect(a.my_each_with_index { |x| x}).to be_a(Hash)
    end

  end

  describe '#my_select' do
    it 'expected value should not be empty' do
      expect([1, 2, 3].my_select { |x| x > 1 }).not_to be_empty
    end

    it 'returns items that meet a condition' do
      expect([1, 2, 3].my_select { |x| x > 1 }).to eql([2, 3])
    end

    it 'returns enumerable when no block given' do
      expect([1, 2, 3].my_select).to be_a(Enumerator)
    end

    it 'does not mutate original array' do
      expect([1, 2, 3].my_select { |x| x + 1}).to eql([1, 2, 3])
    end

    it 'returns an array when called on a Range' do
      expect((1..10).my_select { |x| x > 8 }).to be_a(Array)
    end
  end

  describe '#my_all?' do
    it 'returns true if all items meet condition otherwise return false' do
      expect([1, 2, 3].my_all? { |x| x > 100 }).to be false
    end

    it "returns false if all items don't meet condition otherwise return true" do
      expect([1, 2, 3].my_all? { |x| x > 100 }).not_to be true
    end

    a = [1, 2, 3]
    it "It does not mutate original array" do
      expect(a).to eql([1, 2, 3])
    end

    c = (1..5)
    it "Return true when called on a Range with no args" do
      expect(c.my_all?).to be true
    end

    it "Returns true when no argument given" do
      expect(c.my_all?()).to be true
    end

    it "Returns true when all items match Class passed in" do
      expect(c.my_all?(Integer)).to be true
    end

    it "Returns true when regex match" do
      expect(['abcd'].my_all?(/abc/)).to be true
    end

  end

  describe '#my_any' do
    it 'returns true if any of the items meets condition' do
      expect([7, 8, 9].my_any? { |x| x > 8 }).to be true
    end

    it 'returns false if none of the items meets condition' do
      expect([7, 8, 9].my_any?(String) { |x| x > 8 }).not_to be_a(Array)
    end

    y = [7, 8, 9]
    it 'does not mutate original array' do
      y.my_any? { |x| x > 8 }
      expect(y).to eql([7, 8, 9])
    end

    it 'returns range when called on a range' do
      i = (1..4)
      i.my_any? { |x| x > 8 }
      expect(i).to eql(1..4)
    end

    it 'returns true when no argument is given' do
      expect(y.my_any?).to be true
    end
  end

  describe '#my_none' do
    it 'returns true if none of the items meet condition' do
      expect([1, '2', 'a', 3].my_none?(Hash)).to be true
    end

    it 'returns false if one of the items meet condition' do
      expect([1, '2', 'a', 3].my_none?(String)).not_to be true
    end
  end

  describe '#my_count' do
    it 'returns the number of items meeting a condition' do
      expect([1, 2, 3].my_count { |x| x > 1 }).to eql(2)
    end

    it "doesn't return falsy value if condition met" do
      expect([1, 2, 3].my_count { |x| x > 1 }).not_to be_falsey
    end
  end

  describe '#my_map' do
    it 'returns new arr with items meeting a condition' do
      expect([1, 2, 3].my_map { |x| x * 2 }).to eql([2, 4, 6])
    end

    it "if condition is met it shouldn't return empty" do
      expect([1, 2, 3].my_map { |x| x * 2 }).not_to be_empty
    end
  end

  describe '#my_inject' do
    it 'returns the product of arguments passed in' do
      expect([1, 2, 3].my_inject { |item, next_item| item * next_item }).to be_a(Integer)
    end

    it 'expected truthy value' do
      expect([1, 2, 3].my_inject { |item, next_item| item * next_item }).not_to be_falsey
    end
  end
end
