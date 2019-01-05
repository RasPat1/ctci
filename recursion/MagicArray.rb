# A magic index is an array A[0...n-1] is defined to be an index such that A[i] = i.
# Given a sorted array of distinct integers, write a method to find a magic index
# , if one exists, in array A
# Part 2 What if the values are not distinct?

# Most basic solution: Linearly check each value and compare to index
# => That's always Theta(n)
# slightly optimised: Linearly check each value and once the alg encounters a value
# that is larger than the index go to that index + 1
# => O(n)
# Where is teh recursion and dynamic programming?
# Can we do a binary type search subproblem?
# Whhat if
# we keep a bit array of values 0 - n-1
# Each time we explore index i and find value not i
# We can eliminate both i and all values less than A[i] since it's sorted, right?
# Is this any better timewise?
# Check the middle value if it is smaller than its index we know
# p 146

class MagicArray
  def call(arr)
    # Array is sorted!
    index = 0
    magic_indexes = []
    iterations = 0;

    while index < arr.size
      iterations += 1
      if arr[index] == index
        magic_indexes << index
      elsif arr[index] > index
        index = arr[index]
      end

      index += 1
    end

    puts (magic_indexes.size > 0) ? magic_indexes.join(',') : "No Magic"
    puts "Iterations: #{iterations}"
  end

  # do a binary search type situation here
  # Also we only need to return 1 index
  def callFast(arr, start = 0, finish = nil, iterations = 0)
    finish ||= arr.size - 1
    midvalue = (start + finish) / 2
    iterations += 1

    puts "Searching between #{start} and #{finish}. Index #{midvalue} => #{arr[midvalue]}"

    if arr[midvalue] == midvalue
      puts "Found: #{midvalue} -- Iterations: #{iterations}"

      return midvalue
    elsif start > finish
      puts "No Magic: #{iterations} iterations"
      return -1
    elsif arr[midvalue] > midvalue
      # check left
      return callFast(arr, start, midvalue - 1, iterations)
    else
      # check right
      return callFast(arr, midvalue + 1, finish, iterations)
    end

    return -1
  end
end

class RandArray
  def call(size)
    result = []
    while result.size < size
      num = ((rand * size * 2).floor) - size
      result << num
      result = result.uniq
    end

    result.sort
  end
end


tests = [
  [0,1,2,3,4,5,6,7],
  [1,2,3,4,5,6,7,8],
  RandArray.new.call(100),
  RandArray.new.call(100),
  RandArray.new.call(100),
  RandArray.new.call(100)
]

tests.each do |test|
  puts test.join(',')
  MagicArray.new.callFast(test)
end
