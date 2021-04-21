module Enumerable
  # my_each
  def my_each
    arr = to_a
    for i in arr
      yield i
    end
    arr
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

  #my_all
  def my_all
    new_arr = []
    self.my_each do |num|
      new_arr.push(num) if yield num
    end
    new_arr.length == self.length
  end

  #my_any
  def my_any
    new_arr = []
    self.my_each do |num|
      new_arr.push(num) if yield num
    end
    if new_arr.length >= 1
      true
    else 
      false
    end
  end

   #my_none
  def my_none
    new_arr = []
    self.my_each do |num|
      new_arr.push(num) if yield num
    end
    if new_arr == []
      true
    elsif new_arr.length >= 1
      false
    end
  end

end

a = [1, 2, 3, 4, 5, 10, 100, 1000]

# My method calls

a.my_each do |num|
  num
end

# a.my_each_with_index do |x, i|
#   p "#{i}: #{x}"
# end

# a.my_select(&:even?)

# a.my_all do |i|
#   i > 2
# end

# a.my_any do |i|
#   i > 100
# end

# a.my_none do |i|
#   i > 10000
# end
