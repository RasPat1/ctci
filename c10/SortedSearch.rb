# Sorted Search, No Size
# You are given an array-like data structure Listy which lacks a size method. It does, however, have an elementAt(i) method that returns the element at index i in 0( 1) time. If i is beyond the bounds of the data structure, it returns -1. (For this reason, the data structure only supports positive integers.) Given a Listy which contains sorted, positive integers, find the index at which an element x occurs. If x occurs multiple times, you may return any index.
# Hints: #320, #337, #348

# oh my
# this feels like binary search from the left
# like table doubling exploration
# how about we try 0 if its -1 we return the lement is not in teh array
# if its a value larger than x we rturn -1 its not in teh array
# if its smaller we keep going
# then try twice taht aka element 2 or index 1
# same drill
# then element 4 aka index 3
# same drill
# we keep doing this until we find a vlaue that is larger
# than x
# now we know that x is between element 2^k and 2^k-1
# continue to do binary serach shrinking down the values
# so its like a lg zoom out
# and then a lg zoom in
# if LIsty is at most size n it takes lgn steps to go past the end of list
# if we go past teh end of the list we'll have to keep zooming in
# We do lg search to find teh end of teh list or the max bound on or value
# lg zoom out, lg zoom-in to the end of Listy, lg zoom to find element
# This should be O(lg n)

class SortedSearch
  def call(list, target)
    size = find_array_size(list)
    # takes lg n time so this its find to dplicate teh work for Big O

    # do binary search to find the target

    low = 0
    high = size


    while low <= high
      mid = (low + high) / 2
      elem = list.element_at(mid)

      if elem < target
        low = mid + 1
      elsif elem > target
        high = mid - 1
      else
        return mid
      end
    end

    return -1
  end

  def find_array_size(list)
    # First find our uppper bound via doubling
    low = 0
    high = 0

    while list.element_at(high) != -1
      low = high
      high = (high + 1) * 2 - 1
    end

    while low <= high
      mid = (high + low) / 2
      if list.element_at(mid) == -1
        # hit the top start splitting back down
        high = mid - 1
      else
        low = mid + 1
      end
    end

    low
  end

  def update_index(max_in_bounds, min_out_bounds)
    # grow unbounded until we find some limit
    # then binary search to find the endpoint
    if min_out_bounds == nil
      (max_in_bounds + 1) * 2 - 1
    else
      (max_in_bounds + min_out_bounds) / 2
    end
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

  def element_at(i)
    if i > @data.size - 1
      return -1
    else
      @data[i]
    end
  end
end

data = [1, 2, 5, 9, 20, 50, 99, 100, 101, 240]
l = Listy.new(data)
p SortedSearch.new.call(l, -5) == -1
p SortedSearch.new.call(l, 1) == 0
p SortedSearch.new.call(l, 25) == -1
p SortedSearch.new.call(l, 240) == 9
p SortedSearch.new.call(l, 400) == -1