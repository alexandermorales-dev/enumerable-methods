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
    my_arr = []
    self.my_each do |num|
      my_arr.push(num) if yield num
    end
    my_arr
  end
end

a = [1, 2, 3, 4, 5]

# My method calls

a.my_each do |num|
  num
end

a.my_each_with_index do |x, i|
  p "#{i}: #{x}"
end

a.my_select(&:even?)
