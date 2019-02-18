# Permutations with Dups
# Write a method to compute all permutations of a string whose charac­ters are not necessarily unique. The list of permutations should not have duplicates.

# Hints:#761, #790, #222, #255

# Duplicates should be not part of the prermutation
# I guess we coudl run unqiue on this and then do the same permutation preocedure as before

class PermDupes
  def call(str)
    results = []
    # use a hash table here to determien what vcharacters
    # we've alrday used
    find_perms(str.chars, [], results)
    "#{results}"
  end

  def find_perms(str, prefix = [], results)
    # let's have a set telling us which characters have been in this position before
    # If they have been in this position then let's not recurse down this path again

    results << prefix.join if str.size == 0

    hash_set = {}
    str.each_with_index do |char, index|
      next if hash_set.key?(char)
      hash_set[char] = true

      p_clone = prefix.clone
      p_clone << char
      sub_str = str.clone

      sub_str.delete_at(index)
      find_perms(sub_str, p_clone, results)
    end

    nil
  end

end


str = 'aaabb'
output = [
  ['a', 'a', 'b'],
  ['a', 'b', 'a'],
  ['b', 'a', 'a'],
]
puts PermDupes.new.call(str)