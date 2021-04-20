module Enumerable
  # my_each
  def my_each
    x = self
    for i in x
      yield i
    end
  end

  # my_each_with_index
  def my_each_with_index
    for i in self
      a = i
      b = index(a)
      yield a, b
    end
  end

  # my_select
  def my_select
    self.my_each do |num|
      yield num
    end
  end
end

a = [1, 2, 3, 4, 5]

# My method calls

a.my_each do |num| # MY EACH
  num
end

a.my_each_with_index do |x, i| # MY EACH WITH INDEX
  p "the index of #{x} is #{i}"
end

a.my_select do |n| # MY SELECT
  p n.even?
end