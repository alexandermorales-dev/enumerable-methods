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