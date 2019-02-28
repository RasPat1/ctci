class SortedSearch
  # Return the index of the target in the list
  def call(list, target)
    # We do not know the size of the target
    # But let's do binary search from one side
    iterations = 0
    low = 0
    high = 0
    result = -1

    while low <= high
      iterations += 1
      mid = (low + high) / 2
      value = list.element_at(mid)

      # listy returns -1 if index is out of bounds
      # listy is not allowed to have negative numbers
      if value == -1
        high = mid - 1
      elsif value > target
        high = mid - 1
      elsif value < target
        low = mid + 1
        high = low * 2
      elsif value == target
        result = mid
        break
      end
    end

    puts "#{target}: #{iterations}"

    return result
  end
end

class Listy
  attr_accessor :data
  def initialize(data = [])
    @data = data
  end

  def size
    raise Error.new("No Size method for Listy. Muhahahah")
  end

  def add(val)
    raise Error.new("No Negative numbers plz..") if val < 0
    @data << val
  end

  def element_at(i)
    if i > @data.size - 1
      return -1
    else
      @data[i]
    end
  end
end

data = [
  1, 2, 5, 9, 20, 50, 99, 100, 101, 240, 250, 300, 350, 401
]
l = Listy.new(data)
p SortedSearch.new.call(l, 1) == 0
p SortedSearch.new.call(l, 2) == 1
p SortedSearch.new.call(l, 5) == 2
p SortedSearch.new.call(l, 9) == 3
p SortedSearch.new.call(l, 20) == 4
p SortedSearch.new.call(l, 50) == 5
p SortedSearch.new.call(l, 99) == 6
p SortedSearch.new.call(l, 100) == 7
p SortedSearch.new.call(l, 101) == 8
p SortedSearch.new.call(l, 240) == 9
p SortedSearch.new.call(l, 250) == 10
p SortedSearch.new.call(l, 300) == 11
p SortedSearch.new.call(l, 350) == 12
p SortedSearch.new.call(l, 401) == 13

p SortedSearch.new.call(l, -5) == -1
p SortedSearch.new.call(l, 25) == -1
p SortedSearch.new.call(l, 400) == -1