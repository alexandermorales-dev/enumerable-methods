require './script.rb'

describe Enumerable do
  describe "#my_each" do
    it "prints each item in the iterable and returns original array" do
      expect([1, 2, 3].my_each { |x| puts x }).to eql([1, 2, 3])
    end

    it "returns an Enumerator when no block is given" do
      expect([1, 2, 3].my_each).not_to be_a(Array)
    end
  end
end

describe Enumerable do
  describe "#my_each_with_index" do
    it "prints current item and its index and returns original array" do
      expect([4,5,6].my_each_with_index { |x,v| puts "#{x} is at position #{v}"}).to eql([4,5,6])
    end
  end
end

describe Enumerable do
  describe "#my_select" do
    it "returns items that meet a condition" do
      expect([1,2,3].my_select { |x| x > 1 }).not_to be_empty
    end

    it "returns items that meet a condition" do
      expect([1,2,3].my_select { |x| x > 1 }).to eql([2, 3])
    end
  end
end

describe Enumerable do
  describe "#my_all?" do
    it "returns true if all items meet condition otherwise return false" do
      expect([1,2,3].my_all? { |x| x > 100 }).to be false
    end

    it "returns false if all items don't meet condition otherwise return true" do
      expect([1,2,3].my_all? { |x| x > 100 }).not_to be true
    end
  end
end

describe Enumerable do
  describe "#my_any" do
    it "returns true if any of the items meets condition" do
      expect([7,8,9].my_any? { |x| x > 8 }).to be true
    end

    it "returns false if none of the items meets condition" do
      expect([7,8,9].my_any?(String) { |x| x > 8 }).not_to be_a(Array)
    end
  end
end

describe Enumerable do
  describe "#my_none" do
    it "returns true if none of the items meet condition" do
      expect([1, '2', 'a', 3].my_none?(Hash)).to be true
    end

    it "returns false if one of the items meet condition" do
      expect([1, '2', 'a', 3].my_none?(String)).not_to be true
    end
  end
end

describe Enumerable do
  describe "#my_count" do
    it "returns the number of items meeting a condition" do
      expect([1,2,3].my_count { |x| x > 1 }).to eql(2)
    end

    it "doesn't return falsy value if condition met" do
      expect([1,2,3].my_count { |x| x > 1 }).not_to be_falsey
    end
  end
end

describe Enumerable do
  describe "#my_map" do
    it "returns new arr with items meeting a condition" do
      expect([1,2,3].my_map { |x| x * 2 }).to eql([2, 4, 6])
    end

      it "if condition is met it shouldn't return empty" do
      expect([1,2,3].my_map { |x| x * 2 }).not_to be_empty
    end
  end
end