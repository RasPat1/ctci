class PairDiff
  def call(arr, target_diff)
    arr = arr.sort
    results = []

    # difference must be greater than 0
    # Elements are all unique

    left = 0
    right = 1

    while left < arr.size - 1 && right < arr.size
      diff = arr[right] - arr[left]

      if target_diff == diff
        results << Pair.new(arr[right], arr[left])
      end

      if right - left <= 1 || diff < target_diff
        right += 1
      elsif diff >= target_diff
        left += 1
      end
    end

    results
  end
end
class Pair
  attr_accessor :left, :right

  def initialize(left, right)
    @left = left
    @right = right
  end

  def to_s
    "(#{left}, #{right})"
  end
end

tests =
[
  [1,7,5,9,2,12,3],
  [],
  [1,2],
  [3,2,1]
]

tests.each do |test|
  puts PairDiff.new.call(test, 1)
end
