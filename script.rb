module Enumerable
  # my_each
  def my_each
    for i in self
      yield i
    end
    self
  end

  # my_each_with_index
  def my_each_with_index
    for i in self
      a = i
      b = index(a)
      yield a, b
    end
    self
  end

  # my_select
  def my_select
    newArr = []
    self.my_each do |item|
      yield item
      newArr.push(item) if yield item
    end
    newArr
  end

end

a = [1, 2, 3, 4, 5]

# My method calls

a.my_each do |num| # MY EACH
  p num
end


a.my_each_with_index do |x, i| # MY EACH WITH INDEX
  p "the index of #{x} is #{i}"
end


a.my_select do |n| # MY SELECT
  n.even?  
end

# a.my_all do |n|
#   p n > 2
# end

# a.all? do |n|
#   p n > 2
# end
