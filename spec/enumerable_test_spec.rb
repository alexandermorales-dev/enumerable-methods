require './script.rb'

describe Enumerable do
  describe "#my_each" do
    it "returns each item in the iterable" do
      expect([1, 2, 3].my_each { |x| x }).to eql([1, 2, 3])
    end
  end
end