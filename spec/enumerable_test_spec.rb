require './script.rb'

describe Enumerable do
  describe "#my_each" do
    it "prints each item in the iterable and returns original array" do
      expect([1, 2, 3].my_each { |x| puts x }).to eql([1, 2, 3])
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