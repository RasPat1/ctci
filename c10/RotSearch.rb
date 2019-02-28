# Search in Rotated Array
# Given a sorted array of n integers that has been rotated an unknown number of times, write code to find an element in the array. You may assume that the array was originally sorted in increasing order.

# EXAMPLE
# lnput:findSin{lS, 16, 19, 20, 25, 1, 3, 4, 5, 7, 10, 14} Output: 8 (the index of 5 in the array)
# Hints:#298, #370

class RotSearch
  # Do a linear search to find teh partitoin point
  # Then do binary serach pretending that the array is contiguous right?

  # So we have left, right, mid in typical binary serach
  # in this case we can determine left, right and mid and then wrap around for the start and end of the array. Hmm how do our numbers work exactly

  # when we start high is actualyl lower than low
  # first mid point is partitoin point + 1/2 size of array mod array size
  # if we're larger than that we can go to midpoint to partition point (which may span the array)
  # i mean lol we oculd just be super simple and say lets find the parition point
  # then copy the array into a normal array of size n and then do normal binary serach lol

  def call(arr, target)
    # shift size has the index of the max element
    max_element_index = 0

    # oh we can do binary search to find the max
    # and get this to lgn so the whoel function is lg n
    # this is the bottleneck. I mean also if we're goign to do a linear search to find the max then we're already linear lol
    arr.each_with_index do |curr_val, index|
      next_val = arr[index + 1]
      if next_val && curr_val > next_val
        max_element_index = index
        break
      end
    end

    #


    # low = 0
    # high = arr.size - 1
    # mid = (low + high) / 2

    # while low <= high
    #   if target > arr[mid]
    #     if arr[low] < arr[mid] # normal left side
    #       low = mid + 1 # go to the right
    #     elsif arr[low] > arr[mid]
    #       if target > arr[low]
    #         high = mid - 1
    #       elsif target < arr[low]
    #         low = mid + 1
    #       elsif target == arr[low]
    #         return low
    #       end
    #     end
    #   elsif target < arr[mid]
    #   else
    #     return mid
    #   end

    # end




    # ya know low and high are just for clauclating midpoints
    # the only thing that neesd to be moded is midpoint for access
    # keyinsight is just imaging the array extends out to the right and is "doubled" and our midpoint could be in the virtual doubled array or part of the regular array but doesnt matter/ That's actually so so so cool

    low = max_element_index + 1
    high = max_element_index + arr.size
    midpoint = (low + high) / 2

    # here's straight binary search
    while low <= high
      val = arr[midpoint % arr.size]

      if target > val
        low = midpoint + 1
      elsif target < val
        high = midpoint - 1
      else
        return midpoint % arr.size
      end

      midpoint = (low + high) / 2
    end

    return -1
  end
end
arr0 = [15, 16, 19, 20, 25, 1, 3, 4, 5, 7, 10, 14]
arr1 = [1, 3, 4, 5, 7, 10, 14, 15, 16, 19, 20, 25]
arr2 = [25, 1, 3, 4, 5, 7, 10, 14, 15, 16, 19, 20]
arr3 = [3, 4, 5, 7, 10, 14, 15, 16, 19, 20, 25, 1]

p RotSearch.new.call(arr0, 5) == 8
p RotSearch.new.call(arr1, 5) == 3
p RotSearch.new.call(arr2, 5) == 4
p RotSearch.new.call(arr3, 5) == 2