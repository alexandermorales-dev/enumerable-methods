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

    x = to_a if to_a.is_a? Range
    x = self if to_a.is_a? Array
    i = 0
    while i < x.length
      yield x[i], i
      i += 1
    end
    self
  end

  # my_select
  def my_select
    return to_enum(:my_select) unless block_given?

    my_arr = []
    to_a.my_each do |num|
      my_arr.push(num) if yield num
    end
    my_arr
  end

  # my_all
  def my_all?(param = nil)
    if !block_given? && param.nil?
      to_a.my_each { |num| return false if num == false || num.nil? }
    elsif !block_given? && (param.is_a? Class)
      to_a.my_each { |item| return false if item.class != param }
    elsif !block_given? && (param.is_a? Regexp)
      to_a.my_each { |items| return false unless items.match(param) }
    elsif block_given?
      to_a.my_each { |num| return false unless yield num }
    end
    true
  end

  # my_any
  def my_any?(param = nil)
    if !block_given? && param.nil?
      to_a.my_each { |num| return true if num }
      return false
    elsif param.is_a?(Class)
      to_a.my_each { |num| return true if num.instance_of?(param) }
      return false
    else
      to_a.my_each { |num| return true if yield num }
    end
    false
  end

  # my_none
  def my_none?(param = nil)
    if !block_given? && param.nil?
      to_a.my_each { |num| return true if num == false || num.nil? }
      return false
    elsif !block_given? && param.is_a?(Class)
      to_a.my_each { |num| return false if num.instance_of?(param) }
      return true
    elsif block_given? && param.instance_of?(Range)
      to_a.my_each { |num| return false if yield num }
      return true
    elsif !block_given? && param.instance_of?(Regexp)
      to_a.my_each { |item| return false if item.match(param) }
      return true
    else
      to_a.my_each { |num| return false if yield num }
    end
    true
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
  def my_map(proc = nil)
    return to_enum(:my_map) unless block_given?

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
