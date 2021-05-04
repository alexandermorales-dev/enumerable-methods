# rubocop: disable Metrics/ModuleLength
# rubocop: disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
# rubocop: disable Lint/ToEnumArguments

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

    x = to_a
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
      to_a.my_each { |item| return false if item == false || item.nil? }
    elsif !block_given? && param.is_a?(Class)
      to_a.my_each { |item| return false unless [item.class, item.class.superclass].include?(param) }
    elsif !block_given? && (param.is_a? Regexp)
      to_a.my_each { |item| return false unless item.match(param) }
    elsif !block_given? && !param.nil?
      to_a.my_each { |item| return false unless item == param }
    elsif block_given?
      to_a.my_each { |item| return false unless yield item }
    end
    true
  end

  # my_any
  def my_any?(param = nil)
    if !block_given? && param.nil?
      to_a.my_each { |num| return true if num }
      return false
    elsif param.is_a?(Class)
      to_a.my_each { |num| return true if [num.class, num.class.superclass].include?(param) }
    elsif param.is_a?(Regexp)
      to_a.my_each { |num| return true if num.match(param) }
    elsif !block_given? && !param.nil?
      to_a.my_each { |num| return true if num == param }
    else
      to_a.my_each { |num| return true if yield num }
    end
    false
  end

  # my_none
  def my_none?(param = nil)
    if !block_given? && param.nil?
      to_a.my_each { |num| return false unless num == false || num.nil? }
    elsif !block_given? && param.is_a?(Class)
      to_a.my_each { |num| return false if num.instance_of?(param) }
      return true
    elsif block_given? && param.instance_of?(Range)
      to_a.my_each { |num| return false if yield num }
      return true
    elsif !block_given? && param.instance_of?(Regexp)
      to_a.my_each { |num| return false if num.match(param) }
      return true
    elsif !block_given? && !param.nil?
      to_a.my_each { |num| return false if num == param }
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
  def my_inject(*param)
    collection = is_a?(Range) ? to_a : self

    reduce = param[0] if param[0].is_a?(Integer)
    operator = param[0].is_a?(Symbol) ? param[0] : param[1]

    if operator
      collection.my_each { |item| reduce = reduce ? reduce.send(operator, item) : item }
      return reduce
    end
    collection.my_each { |item| reduce = reduce ? yield(reduce, item) : item }
    reduce
  end
end

# rubocop: enable Metrics/ModuleLength
# rubocop: enable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
# rubocop: enable Lint/ToEnumArguments

# testing my_inject
def multiply_els(array)
  array.my_inject { |item, next_item| item * next_item }
end

# a = {
#   :b => 1,
#   :c => 2,
#   :d => 'a'
# }

# my_proc = Proc.new { |x| x * 2 }

# a = [1, 2, 3].each(&my_proc) { |x| x + 1}
# a = [1, 2, 3].map(&my_proc) { |x| x + 1}

# p [1, 2, 3].inject

p (1..5).my_inject { |item, next_item| item * next_item }