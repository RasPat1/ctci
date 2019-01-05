# Generate all subsets of the given set


# Okay there are a buuunch of ways to do this prob!
# What's the first thing that comes to mind
# Each element in the set can be either included or excluded
# This binary starte could esily correspond to us counting
# in binary
# Count in binary up to 2^(# of elements)
# for each number add the set to the output set
# We can iterate in base ten and bit shift off
# to determine whtehr it should be included

# Or we could just do straight recursion right
# take the current set (null set) and generate both sets where
# hints: 273, 290, 338, 354, 373
class PowerSet

  def call(set, results = [[]])
    if set.empty?
      return results
    end

    new_results = []

    item = set.shift
    results.each do |result|
      new_results << result.clone
      new_results << (result << item)
    end

    call(set, new_results)
    # call(set, new_results.uniq)
  end

  def callFast(set)
    all_results = []
    set_size = set.size
    max = (2 ** set_size) - 1

    0.upto(max) do |count|
      org_count = count
      set_index = 0
      result = []

      while count > 0 && set_index < set_size
        if count % 2 == 1
          result << set[set_index]
        end
        set_index += 1
        count /= 2
      end

      all_results << result.clone
    end

    all_results
  end
end

# sets = PowerSet.new.call([1,2,2,3])
sets = PowerSet.new.callFast([1,2,2,3])

puts sets.size
sets.each do |set|
  puts "{#{set.join(',')}}"
end

def profile
  test_sets = [
    [1,2,3],
    [1,2,2,3,4,5,6,7,8,9,10],
    [1,2,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19],
    [5] * 21,
    [20] * 22
  ]
  solutions = [
    :call,
    :callFast
  ]
  solutions.each do |solution|
    test_sets.each do |test|
      test_set = test.clone
      start = Time.now
      set = PowerSet.new.send(solution, test_set)
      stop = Time.now
      puts "Version: #{solution}, Test Size: #{test.size}, Result Size: #{set.size}, Time: #{stop - start}"
    end

  end
end
profile