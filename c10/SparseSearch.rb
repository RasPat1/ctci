# Sparse Search
# Given a sorted array of strings that is interspersed with empty strings, write a method to find the location of a given string.

class SparseSearch
  # In the owrst case i can't see how we do better than O(n)
  # Imagine an array of size n filled with empty strings
  # And searchgin for a non-empty string. The only way to be sure the non-empty string is absent form teh array
  # is to inspect n elements
  def call(input, target)
    # Approach that could be good in the average case
    # Let's scan from the left and scan form the right
    # we've established our initial range
    # if the targetis in teh range okay great let's do binary search
    # If not let's get out
    # select the center of the array
    # if it is not blank than we can determine which half of the array our target may be at
    # if it is blank then let's scan left and right until we hit a word (alternate left and rgiht is most efficient)
    # once we hit a word we can now determine which half of the array we need to look at
    # then continue on that side


    low = 0
    high = input.size - 1

    # start by scannign left
    # while input[low] == ""
    #   low += 1
    # end
    # while input[high] == ""
    #   high -= 1
    # end

    # # hey maybe we found it on the bounds?
    # if input[low] == target
    #   return low
    # elsif input[high] == target
    #   return high
    # elsif target < input[low] && target > input[high]
    #   return -1
    # end

    while low <= high
      mid = (low + high) / 2

      mid = find_non_blank_mid(mid, input, low, high)
      return -1 if input[mid] == ""

      if input[mid] > target
        high = mid - 1
      elsif input[mid] < target
        low = mid + 1
      else
        return mid
      end
    end

    -1
  end

  def find_non_blank_mid(mid, input, low, high)
    mid_left = mid
    mid_right = mid

    while mid_left >= low || mid_right <= high

      return mid_left if input[mid_left] != ""
      return mid_right if input[mid_right] != ""
      # p "#{low}:#{mid_left}:#{mid}:#{mid_right}:#{high}"
      mid_left -= 1
      mid_right += 1
    end

    mid
  end
end

input = [
  "at", "", "", "", "",
  "ball", "",  "",  "",  "",  "",
  "car",  "",  "",  "",
  "dad", "",
]

p SparseSearch.new.call(input, "at") == 0
p SparseSearch.new.call(input, "ball") == 5
p SparseSearch.new.call(input, "car") == 11
p SparseSearch.new.call(input, "dad") == 15
p SparseSearch.new.call(input, "aaa") == -1
p SparseSearch.new.call(input, "bbb") == -1
p SparseSearch.new.call(input, "ccc") == -1
p SparseSearch.new.call(input, "ddd") == -1
p SparseSearch.new.call(input, "eee") == -1
p SparseSearch.new.call(input, "zzz") == -1