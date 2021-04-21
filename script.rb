module Enumerable
  # my_each
  def my_each
    i = 0
    while i < to_a.length
      yield to_a[i]
      i += 1
    end
    self
  end

  # my_each_with_index
  def my_each_with_index
    i = 0
    while i < to_a.length
      yield to_a[i], index(to_a[i])
      i += 1
    end
    self
  end

  # my_select
  def my_select
    my_arr = []
    to_a.my_each do |num|
      my_arr.push(num) if yield num
    end
    my_arr
  end

  # my_all
  def my_all
    new_arr = []
    to_a.my_each do |num|
      new_arr.push(num) if yield num
    end
    new_arr.length == to_a.length
  end

  # my_any
  def my_any
    new_arr = []
    to_a.my_each do |num|
      new_arr.push(num) if yield num
    end
    new_arr.length >= 1
  end

  # my_none
  def my_none
    new_arr = []
    to_a.my_each do |num|
      new_arr.push(num) if yield num
    end
    new_arr.length.zero?
  end

  # my_count
  def my_count(par = nil)
    count = 0
    if block_given?
      to_a.my_each { |num| count += 1 if yield num }
    elsif !block_given? && par.nil?
      count = to_a.length
    else
      to_a.my_each { |num| count += 1 if num == par }.length
    end
    count
  end

  # my_map 
  def my_map
    new_arr = []
    if block_given?
      to_a.my_each { |num| new_arr.push(yield num) }
    else
      to_a.my_each { |num| new_arr.push(num) }
    end
    new_arr
  end
  # def my_map(proc = nil)
  #   new_arr = []
  #   if proc.nil?
  #     to_a.my_each { |num| new_arr.push(yield(num)) }
  #   else
  #     to_a.my_each { |num| new_arr.push(proc.call(num)) }
  #   end
  #   new_arr
  # end
end

a = [1, 2, 3, 4, 5, 10, 100, 100, 100, 1000, 40]
b = ['asda', 'asdasda']

# My method calls

# a.my_each do |num|
#   num
# end

# my_each_with_index do |value, ind|
#   puts "#{value} #{ind}"
# end

# a.my_select(&:even?)

# a.my_all { |num| num > 10 }

# a.my_any { |num| num > 1000 }

# a.my_none { |num| num > 999 }

# a.my_count { |num| num == 100 }

y = a.my_map { |num| num * 3 }

p y
p a


 
# p a.my_map { |num| num > 2 }
# p a.each { |num| num > 2 }
# p a.my_each { |num| num > 2 }
