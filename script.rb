module Enumerable
  def my_each
    x = self
    for i in x
      yield i
    end
  end
end

# method calls
a.my_each do |num|
  num
end
