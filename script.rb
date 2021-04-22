module Enumerable
  # my_each
  def my_each
    return to_enum(:my_each) unless block_given?
    i = 0
    while i < to_a.length
      yield to_a[i]
      i += 1
    end
    self
  end

  # my_each_with_index
  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?
    x = self.to_a if self.class == Range
    x = self if self.class == Array
    i = 0
    while i < x.length
      yield x[i], i
      i += 1
    end
    self
  end

  # my_select
  def my_select
    return to_enum unless block_given?
    my_arr = []
    to_a.my_each do |num|
      my_arr.push(num) if yield num
    end
    my_arr
  end

  # my_all
  def my_all?(param = nil)
    if !block_given? && param == nil
      to_a.my_each { |num| return false if num == false || num.nil? } 
    elsif !block_given? && (param.is_a? Class)
      to_a.my_each { |item| return false if item.class != param }
    elsif block_given?
      to_a.my_each { |num| return false if !yield num }
    end
    true
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
  def my_map_proc(proc = nil)
    new_arr = []
    if proc.nil?
      to_a.my_each { |num| new_arr.push(yield(num)) }
    else
      to_a.my_each { |num| new_arr.push(proc.call(num)) }
    end
    new_arr
  end

  # my_inject
  def my_inject(init_value = nil)
    if init_value.nil?
      accum = self[0]
      i = 1
    else
      accum = init_value
      i = 0
    end
    while i < to_a.length
      accum = yield accum, self[i]
      i += 1
    end
    accum
  end
end

# testing my_inject
def multiply_els(array)
  array.my_inject { |item, next_item| item * next_item }
end

p ['a', 'b', 'c'].my_all?(String) #{ |num| num < 4 }