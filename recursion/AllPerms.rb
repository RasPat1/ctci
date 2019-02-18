# Permutations without Dups
# Write a method to compute all permutations of a string of unique characters.
# Hints:#150, #185, #200, #267, #278, #309, #335, #356

class AllPerms
  def call(str)
    results = []
    perm_impl(str.chars, [], results)

    puts "Size: #{results.size}"
    fomatted_results = []
    results.each do |result|
      fomatted_results << result.join
    end

    "#{results}"
  end

  def perm_impl(str_arr, prefix = [], results)
    return results << prefix if str_arr.size == 0

    str_arr.each_with_index do |char, index|
      substr = str_arr.clone
      substr.delete_at(index)
      p_clone = prefix.clone
      p_clone << char
      perm_impl(substr, p_clone, results)
    end
  end

  def mix(result, char)
    results = []

    result.size.times do |time|
      new_result = result.clone
      new_result.insert(time, char)
      results << new_result
    end

    results << result.clone.push(char)
    results
  end
end
str = 'abc'
puts AllPerms.new.call(str)