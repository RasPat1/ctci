# Given an array of unsorted numbers
# sort them such that the teh value at index 0 < index 1
# and index 1 > index 2 and index 2 < index 3, etc. etc.

class WiggleSort
  def call(arr)
    a = arr.sort
    result = []

    while a.size > 0
      result << a.shift
      result << a.pop
    end

    result
  end
end

def check(arr)
  puts arr.join(",")
  last_num = nil
  count = 0

  arr.each do |num|
    count += 1
    if last_num != nil
      if count % 2 == 0
        return false if last_num >= num
      else
        return false if last_num <= num
      end
    end

    last_num = num
  end

  true
end

tests = [
  [1,1,1,4,5,6,7],
  [1,1,1,4,5,6],
  [1,1,1,1,1,4,5,6]
]

tests.each do |test|
  arr = WiggleSort.new.call(test)
  puts check(arr)
end
